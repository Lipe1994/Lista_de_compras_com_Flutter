import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lista_de_compras/core/models/user.dart';
import 'package:lista_de_compras/infra/firebase/firestore_service.dart';

class UserFirestoreService {
  final FirestoreService _firestoreService;
  final CollectionReference<Map<String, dynamic>> _collection;

  UserFirestoreService(this._firestoreService)
      : _collection = _firestoreService.firestore.collection(User.tablename);

  Future<void> add(User user) async {
    var collection = await _firestoreService.firestore
        .collection(User.tablename)
        .where('email', isEqualTo: user.email)
        .get();

    if (collection.size > 0) {
      return;
    }

    await _firestoreService.add(user);
  }

  Future<void> remove(String id) async {
    var collections = await _collection.where('id', isEqualTo: id).get();

    if (collections.size < 1) {
      return;
    }

    for (var c in collections.docs) {
      await c.reference.delete();
    }
  }

  Future<User?> getById(String id) async {
    var res = await _firestoreService.getById(User.tablename, id);
    if (res == null) {
      return null;
    }
    return User.fromMap(res);
  }

  Future<List<User>> getAll(String ownerEmail) async {
    var res = await _firestoreService.getAll(User.tablename, ownerEmail);
    if (res.isEmpty) {
      return [];
    }
    return res.map((e) => User.fromMap(e)).toList();
  }

  Future<User?> getByEmail(String email) async {
    List<User> users = <User>[];

    var collections = await _collection.where('email', isEqualTo: email).get();

    if (collections.size < 1) {
      return null;
    }

    for (var c in collections.docs) {
      users.add(User.fromMap(c.data()));
    }

    return users.first;
  }
}
