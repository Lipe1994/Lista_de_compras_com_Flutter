import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lista_de_compras/core/models/item_list.dart';
import 'package:lista_de_compras/core/models/list_of_shopping.dart';
import 'package:lista_de_compras/core/models/lists_by_user.dart';
import 'package:lista_de_compras/infra/firebase/firestore_service.dart';

class ItemListFirestoreService {
  final FirestoreService _firestoreService;

  ItemListFirestoreService(this._firestoreService);

  Future<CollectionReference<Map<String, dynamic>>> _getCollection(
      String ownerUserAuthId) async {
    var collection = _firestoreService.firestore
        .collection(ListsByUser.tablename)
        .doc(ownerUserAuthId)
        .collection(ListOfShopping.tablename);

    return collection;
  }

  Future add(ItemList item) async {
    var collection = await _getCollection(item.ownerIdAuthUser);

    collection
        .doc(item.idList)
        .collection(ItemList.tablename)
        .doc(item.id)
        .set(item.toMap());
  }

  Future delete(ItemList item) async {
    var collection = await _getCollection(item.ownerIdAuthUser);
    collection
        .doc(item.idList)
        .collection(ItemList.tablename)
        .doc(item.id)
        .delete();
  }

  Future deleteALot(List<ItemList> itens) async {
    var collection = await _getCollection(itens.first.ownerIdAuthUser);

    collection
        .doc(itens.first.idList)
        .collection(ItemList.tablename)
        .where('id', whereIn: itens.map((e) => e.id).toList())
        .get()
        .then((i) => i.docs.forEach((i) => i.reference.delete()));
  }

  Future<ItemList?> getById(ItemList item) async {
    var collection =
        (await _getCollection(item.ownerIdAuthUser)).doc(item.idList);
    var res =
        await collection.collection(ItemList.tablename).doc(item.id).get();
    if (!res.exists) {
      return null;
    }
    return ItemList.fromMap(res.data()!);
  }

  Future<List<ItemList>> getByIdList(ListOfShopping listOfShopping) async {
    List<ItemList> list = <ItemList>[];
    var collection = await _getCollection(listOfShopping.ownerIdAuthUser);

    var res = await collection
        .doc(listOfShopping.id)
        .collection(ItemList.tablename)
        .get();

    if (res.size < 1) {
      return [];
    }

    for (var c in res.docs) {
      list.add(ItemList.fromMap(c.data()));
    }

    return list;
  }

  //Listener
  static StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? refQuery1;
  listener(Function(DocumentChange<Map<String, dynamic>>?) onListner,
      ListOfShopping list) async {
    var collection = await _getCollection(list.ownerIdAuthUser);

    var res = collection.doc(list.id).collection(ItemList.tablename);

    var query1 = res.where('id_list', isEqualTo: list.id);

    refQuery1?.cancel();

    refQuery1 = query1.snapshots().listen((event) {
      for (var element in event.docChanges) {
        onListner(element);
      }
    });
  }

  void dispose() {
    refQuery1?.cancel();
  }
}
