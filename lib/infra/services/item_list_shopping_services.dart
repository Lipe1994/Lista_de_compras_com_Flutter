import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lista_de_compras/core/models/document_changes.dart';
import 'package:lista_de_compras/core/models/item_list.dart';
import 'package:lista_de_compras/core/models/list_of_shopping.dart';
import 'package:lista_de_compras/infra/firebase/item_list_firestore_service.dart';
import 'package:lista_de_compras/infra/preferences/preferences.dart';
import 'package:lista_de_compras/infra/services/list_of_shopping_services.dart';
import 'package:lista_de_compras/infra/services/shared_user_list_service.dart';

class ItemListService {
  final ItemListFirestoreService _itemListFirestoreService;
  final SharedUserListService _sharedUserListService;
  final Preferences _preferences;
  final ListOfShoppingService _listOfShoppingService;

  ItemListService(this._itemListFirestoreService, this._sharedUserListService,
      this._preferences, this._listOfShoppingService);

  //Items da lista
  Future<List<ItemList>> getItemsOnline(ListOfShopping list) async {
    var items = await _itemListFirestoreService.getByIdList(list);
    return items;
  }

  //
  Future addItem(ItemList item) async {
    await checkPermission(item.idList);

    _itemListFirestoreService.add(item);
  }

  Future removeItem(ItemList item) async {
    await checkPermission(item.idList);

    await _itemListFirestoreService.delete(item);
  }

  Future removeALot(List<ItemList> itens) async {
    for (var item in itens) {
      await checkPermission(item.idList);
    }

    await _itemListFirestoreService.deleteALot(itens);
  }

  //Listener
  Future<List<ItemList>?> listner(
      Function(DocumentChanges?) onListner, ListOfShopping list) async {
    await _itemListFirestoreService.listener(
        (value) => onListner(value?.doc.data() != null
            ? DocumentChanges<ItemList>(
                ItemList.fromMap(value!.doc.data()!),
                value.type == DocumentChangeType.added
                    ? DocumentChangesType.add
                    : value.type == DocumentChangeType.removed
                        ? DocumentChangesType.remove
                        : DocumentChangesType.update)
            : null),
        list);
  }

  Future checkPermission(String idList) async {
    var list = await _listOfShoppingService.getById(idList);

    //regra
    var email = (await _preferences.getPreferences())?.email;
    if (email == null) {
      throw Exception('Ops, aconteceu um erro ao tentar validar seu login!');
    }

    if (email == list?.ownerEmail) {
      return true;
    }

    var exists =
        await _sharedUserListService.getByIdListAndEmail(idList, email);

    if (exists != null) {
      return true;
    }

    throw Exception('Permissão não encontrada.');
  }
}
