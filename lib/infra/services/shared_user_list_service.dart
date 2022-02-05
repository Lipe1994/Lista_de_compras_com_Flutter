import 'package:lista_de_compras/core/models/shared_user_list.dart';
import 'package:lista_de_compras/infra/firebase/shared_user_list_firestore_service.dart';
import 'package:lista_de_compras/infra/preferences/preferences.dart';
import 'package:lista_de_compras/infra/services/list_of_shopping_services.dart';
import 'package:lista_de_compras/infra/services/user_service.dart';

class SharedUserListService {
  final SharedUserListFirestoreService _sharedUserListFirestoreService;
  final ListOfShoppingService _listOfShoppingService;
  final UserService _userService;
  final Preferences _preferences;
  String? email;

  SharedUserListService(this._preferences, this._sharedUserListFirestoreService,
      this._listOfShoppingService, this._userService);

  Future<void> add(SharedUserList shared) async {
    var email = (await _preferences.getPreferences())?.email;
    var list = await _listOfShoppingService.getById(shared.idList);

    var user = await _userService.getByEmailOnline(shared.emailUser);

    if (list == null || email == null) {
      throw Exception('Ops, aconteceu um erro ao tentar validar seu login!');
    }

    if (email != list.ownerEmail) {
      throw Exception('Ops, somente o dono da lista poderá compartilhá-la');
    }

    if (user == null) {
      throw Exception(
          'Ops, não foi possível encontrar usuário do compartilhamento.');
    }

    _sharedUserListFirestoreService.add(SharedUserList(
        createdAt: shared.createdAt,
        emailUser: shared.emailUser,
        idList: shared.idList,
        ownerIdAuthUser: shared.ownerIdAuthUser,
        acepted: shared.acepted,
        updatedAt: shared.updatedAt,
        id: user.id));
  }

  Future<SharedUserList?> getByIdListAndEmail(
      String idList, String email) async {
    var res = await _sharedUserListFirestoreService.getByIdListAndEmail(
        idList, email);
    return res;
  }

  Future<List<SharedUserList>> getAllMySharedsByIdList(String idList) async {
    var shareds =
        await _sharedUserListFirestoreService.getAllMySharedsByIdList(idList);

    return shareds;
  }

  Future<void> delete(SharedUserList shared) async {
    _sharedUserListFirestoreService.delete(shared);
    return;
  }
}
