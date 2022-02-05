import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lista_de_compras/core/models/item_list.dart';
import 'package:lista_de_compras/core/models/list_of_shopping.dart';
import 'package:lista_de_compras/core/models/lists_by_user.dart';
import 'package:lista_de_compras/infra/firebase/firestore_service.dart';
import 'package:lista_de_compras/infra/preferences/preferences.dart';

class ListOfShoppingFirestoreService {
  final Preferences preferences;
  final FirestoreService firestoreService;

  ListOfShoppingFirestoreService(this.firestoreService, this.preferences);

  Future<String> _getAuthUserId() async {
    var id = (await preferences.getPreferences())?.authUserId;
    if (id == null) {
      throw Exception('Não foi possível obter o id do usuário.');
    }
    return id;
  }

  Future<CollectionReference<Map<String, dynamic>>> _getCollection(
      {String? ownerIdAuthUser}) async {
    var idUser = await _getAuthUserId();
    var collection = firestoreService.firestore
        .collection(ListsByUser.tablename)
        .doc(ownerIdAuthUser ?? idUser)
        .collection(ListOfShopping.tablename);

    return collection;
  }

  Future add(ListOfShopping list) async {
    var collection =
        await _getCollection(ownerIdAuthUser: list.ownerIdAuthUser);

    collection.doc(list.id).set(list.toMap());
  }

  Future<void> remove(ListOfShopping list) async {
    var collection =
        await _getCollection(ownerIdAuthUser: list.ownerIdAuthUser);
    var res = await collection.doc(list.id).get();

    if (res.exists) {
      await collection.doc(res.id).delete();
    }
  }

  Future<ListOfShopping?> getById(String id) async {
    var collection = await _getCollection();
    var res = await collection.where('id', isEqualTo: id).get();

    if (res.docs.isEmpty) {
      return null;
    }
    return ListOfShopping.fromMap(res.docs.first.data());
  }

  Future<List<ListOfShopping>> getAllBySharedLists(List<String> terms) async {
    List<ListOfShopping> list = <ListOfShopping>[];
    if (terms.isEmpty) {
      return [];
    }

    var collection = await firestoreService.firestore
        .collectionGroup(ListOfShopping.tablename)
        .where('id', whereIn: terms)
        .orderBy('owner_email')
        .get();

    if (collection.docs.isEmpty) {
      return [];
    }

    for (var c in collection.docs) {
      var newList = ListOfShopping.fromMap(c.data());

      newList.itemList = await _populateItems(
          await _getCollection(ownerIdAuthUser: newList.ownerIdAuthUser),
          newList);

      list.add(newList);
    }
    return list;
  }

  Future<List<ListOfShopping>> getByOwnerEmail(String ownerEmail) async {
    List<ListOfShopping> list = <ListOfShopping>[];
    var collection = await _getCollection();

    var filteredCollections =
        await collection.where('owner_email', isEqualTo: ownerEmail).get();

    if (filteredCollections.size < 1) {
      return Future.value(<ListOfShopping>[]);
    }

    for (var c in filteredCollections.docs) {
      var newList = ListOfShopping.fromMap(c.data());

      newList.itemList = await _populateItems(collection, newList);
      list.add(newList);
    }

    return list;
  }

  Future<List<ItemList>> _populateItems(
    CollectionReference<Map<String, dynamic>> collection,
    ListOfShopping list,
  ) async {
    var filteredItensOfCollections =
        await collection.doc(list.id).collection(ItemList.tablename).get();

    List<ItemList> itens = [];

    if (filteredItensOfCollections.docs.isNotEmpty) {
      for (var item in filteredItensOfCollections.docs) {
        itens.add(ItemList.fromMap(item.data()));
      }
    }
    return itens;
  }

  static StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? refQuery1;
  static StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? refQuery2;

  listener(Function(DocumentChange<Map<String, dynamic>>?) onListner,
      String ownerEmail, List<String> ids) async {
    var collection = await _getCollection();

    var query1 = collection.where('owner_email', isEqualTo: ownerEmail);

    refQuery1?.cancel();
    refQuery1 = query1.snapshots().listen((event) {
      for (var element in event.docChanges) {
        onListner(element);
      }
    });

    if (ids.isEmpty) {
      return;
    }

    var query2 = firestoreService.firestore
        .collectionGroup(ListOfShopping.tablename)
        .where('id', whereIn: ids)
        .orderBy('owner_email');

    refQuery2?.cancel();
    refQuery2 = query2.snapshots().listen((event) {
      for (var element in event.docChanges) {
        onListner(element);
      }
    });
  }

  void dispose() {
    refQuery1?.cancel();
    refQuery1?.cancel();
  }
}
