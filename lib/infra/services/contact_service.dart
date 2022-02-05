import 'package:lista_de_compras/core/models/contact.dart';
import 'package:lista_de_compras/infra/firebase/contact_firestore_service.dart';
import 'package:lista_de_compras/infra/preferences/preferences.dart';

class ContactService {
  final ContactFirestoreService _contactFirestoreService;
  final Preferences _preferences;

  ContactService(this._preferences, this._contactFirestoreService);

  Future<Contact?> getByIdOnline(String id) async {
    return await _contactFirestoreService.getById(id);
  }

  Future<Contact?> getByEmailOnline(String email) async {
    var ownerEmail = (await _preferences.getPreferences())?.email;
    return await _contactFirestoreService.getByEmail(email, ownerEmail!);
  }

  Future<List<Contact>> getByEmailsOnline(List<String> emails) async {
    var ownerEmail = (await _preferences.getPreferences())?.email;
    return await _contactFirestoreService.getByEmails(emails, ownerEmail!);
  }

  Future<List<Contact>> getContactsOnline() async {
    var ownerEmail = (await _preferences.getPreferences())?.email;
    return await _contactFirestoreService.getAll(ownerEmail!);
  }

  void addOnline(Contact contact) {
    if (contact.email == contact.ownerEmail) {
      throw Exception('Não é possível adicionar a sí mesmo como contato.');
    }
    _contactFirestoreService.add(contact);
  }

  void removeOnline(String id) {
    _contactFirestoreService.remove(id);
  }
}
