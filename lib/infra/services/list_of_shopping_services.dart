import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lista_de_compras/core/models/document_changes.dart';
import 'package:lista_de_compras/core/models/list_of_shopping.dart';
import 'package:lista_de_compras/core/models/shared_user_list.dart';
import 'package:lista_de_compras/infra/firebase/list_of_shopping_firestore_service.dart';
import 'package:lista_de_compras/infra/firebase/shared_user_list_firestore_service.dart';
import 'package:lista_de_compras/infra/preferences/preferences.dart';

class ListOfShoppingService {
  final ListOfShoppingFirestoreService _listOfShoppingFirestoreService;
  final SharedUserListFirestoreService _sharedUserListFirestoreService;
  final Preferences _preferences;
  String? email;

  ListOfShoppingService(this._listOfShoppingFirestoreService,
      this._sharedUserListFirestoreService, this._preferences);

  Future<List<SharedUserList>> getShareds(String email) async {
    var shareds = await _sharedUserListFirestoreService.getAllMyShareds(email);
    return shareds;
  }

  //Traga lista do dono e as que foram compartilhadas
  Future<List<ListOfShopping>> getListsOnline() async {
    email = email ?? (await _preferences.getPreferences())?.email;

    var data = await _listOfShoppingFirestoreService.getByOwnerEmail(email!);

    var shareds = await getShareds(email!);

    var sharedList = await _listOfShoppingFirestoreService
        .getAllBySharedLists(shareds.map((e) => e.idList).toList());

    data.addAll(
      sharedList.map(
        (e) => ListOfShopping(
            createdAt: e.createdAt,
            ownerIdAuthUser: e.ownerIdAuthUser,
            name: e.name,
            note: e.note,
            ownerName: e.ownerName,
            ownerEmail: e.ownerEmail,
            updatedAt: e.updatedAt,
            id: e.id,
            idUpdateCurrentUser: null,
            isSharedNotAcepted: true,
            itemList: e.itemList),
      ),
    );

    return data;
  }

  //Traga lista do dono e as que foram compartilhadas
  Future<ListOfShopping?> getById(String id) async {
    var data = await _listOfShoppingFirestoreService.getById(id);

    return data;
  }

  //
  Future<void> addList(ListOfShopping listOfShopping) async {
    await checkPermission(listOfShopping.id);

    _listOfShoppingFirestoreService.add(listOfShopping);
  }

  Future<void> removeList(ListOfShopping listOfShopping) async {
    await checkPermission(listOfShopping.id);

    email = email ?? (await _preferences.getPreferences())?.email;

    if (listOfShopping.ownerEmail == email) {
      _listOfShoppingFirestoreService.remove(listOfShopping);
    } else {
      var myshared = await _sharedUserListFirestoreService.getByIdListAndEmail(
          listOfShopping.id, email!);

      _sharedUserListFirestoreService.delete(myshared!);
    }
    return;
  }

  //Listener
  Future<List<ListOfShopping>?> listner(
      Function(DocumentChanges?) onListner) async {
    email = email ?? (await _preferences.getPreferences())?.email;

    var shareds = await getShareds(email!);

    _listOfShoppingFirestoreService.listener(
        (value) => onListner(value?.doc.data() != null
            ? DocumentChanges<ListOfShopping>(
                ListOfShopping.fromMap(value!.doc.data()!),
                value.type == DocumentChangeType.added
                    ? DocumentChangesType.add
                    : value.type == DocumentChangeType.removed
                        ? DocumentChangesType.remove
                        : DocumentChangesType.update)
            : null),
        email!,
        shareds.map((e) => e.idList).toList());
  }

  Future checkPermission(String idList) async {
    var list = await _listOfShoppingFirestoreService.getById(idList);

    if (list == null) {
      return;
    }

    //regra
    var email = (await _preferences.getPreferences())?.email;
    if (email == null) {
      throw Exception('Ops, aconteceu um erro ao tentar validar seu login!');
    }

    if (email == list.ownerEmail) {
      return;
    }

    var exists = await _sharedUserListFirestoreService.getByIdListAndEmail(
        idList, email);

    if (exists != null) {
      return;
    }

    throw Exception('Permissão não encontrada.');
  }
}
