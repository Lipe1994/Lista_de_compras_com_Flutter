import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lista_de_compras/core/models/contact.dart';
import 'package:lista_de_compras/infra/firebase/firestore_service.dart';

class ContactFirestoreService {
  final FirestoreService _firestoreService;
  final CollectionReference<Map<String, dynamic>> _collection;

  ContactFirestoreService(this._firestoreService)
      : _collection = _firestoreService.firestore.collection(Contact.tablename);

  Future<void> add(Contact contact) async {
    var collection = await _collection
        .where('email', isEqualTo: contact.email)
        .where('owner_email', isEqualTo: contact.ownerEmail)
        .get();

    if (collection.size < 1) {
      _firestoreService.add(contact);
    }
  }

  Future<Contact?> getById(String id) async {
    var res = await _firestoreService.getById(Contact.tablename, id);
    if (res == null) {
      return null;
    }
    return Contact.fromMap(res);
  }

  Future<List<Contact>> getAll(String ownerEmail) async {
    var res = await _firestoreService.getAll(Contact.tablename, ownerEmail);
    var list = res.map((e) => Contact.fromMap(e)).toList();
    return list;
  }

  Future<Contact?> getByEmail(String email, String ownerEmail) async {
    List<Contact> contacts = [];

    var collections = await _collection
        .where('email', isEqualTo: email)
        .where('owner_email', isEqualTo: ownerEmail)
        .get();

    if (collections.size < 1) {
      return null;
    }

    for (var c in collections.docs) {
      contacts.add(Contact.fromMap(c.data()));
    }

    return contacts.first;
  }

  Future<List<Contact>> getByEmails(
      List<String> emails, String ownerEmail) async {
    List<Contact> contacts = [];

    var collections = await _collection
        .where('email', whereIn: emails)
        .where('owner_email', isEqualTo: ownerEmail)
        .get();

    if (collections.size < 1) {
      return [];
    }

    for (var c in collections.docs) {
      contacts.add(Contact.fromMap(c.data()));
    }

    return contacts;
  }

  Future<void> remove(String id) async {
    var collections = await _collection.where('id', isEqualTo: id).get();

    if (collections.size < 1) {
      throw Exception('Documento não encontrado.');
    }

    for (var c in collections.docs) {
      c.reference.delete();
    }
  }
}
