import 'package:lista_de_compras/core/models/user.dart';
import 'package:lista_de_compras/infra/firebase/user_firestore_service.dart';

class UserService {
  final UserFirestoreService _userFirestoreService;

  UserService(this._userFirestoreService);

  Future<User?> getByIdOnline(String id) async {
    return await _userFirestoreService.getById(id);
  }

  Future<User?> getByEmailOnline(String email) async {
    return await _userFirestoreService.getByEmail(email);
  }

  Future<void> addOnline(User user) async {
    return await _userFirestoreService.add(user);
  }

  Future<void> removeOnline(String id) async {
    return await _userFirestoreService.remove(id);
  }

  Future<List<User>> getContactsOnline(String ownerEmail) async {
    return await _userFirestoreService.getAll(ownerEmail);
  }
}
