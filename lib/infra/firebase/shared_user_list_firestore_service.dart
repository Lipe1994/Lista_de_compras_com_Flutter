import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lista_de_compras/core/models/lists_by_user.dart';
import 'package:lista_de_compras/core/models/shared_user_list.dart';
import 'package:lista_de_compras/infra/firebase/firestore_service.dart';
import 'package:lista_de_compras/infra/preferences/preferences.dart';

class SharedUserListFirestoreService {
  final FirestoreService _firestoreService;
  final Preferences _preferences;

  SharedUserListFirestoreService(this._firestoreService, this._preferences);

  Future<String> _getAuthUserId() async {
    var id = (await _preferences.getPreferences())?.authUserId;
    if (id == null) {
      throw Exception('Não foi possível obter o id do usuário.');
    }
    return id;
  }

  Future<CollectionReference<Map<String, dynamic>>> _getCollection() async {
    var idUser = await _getAuthUserId();
    var collection = _firestoreService.firestore
        .collection(ListsByUser.tablename)
        .doc(idUser)
        .collection(SharedUserList.tablename);

    return collection;
  }

  Future add(SharedUserList shared) async {
    var collection = await _getCollection();
    var doc = await collection.doc(shared.idList).get();

    if (!doc.exists) {
      collection.doc(shared.id).set(shared.toMap());
    }
  }

  Future<SharedUserList?> getByIdListAndEmail(
      String idList, String email) async {
    List<Map<String, dynamic>> listOfMap = [];

    var docs = await _firestoreService.firestore
        .collectionGroup(SharedUserList.tablename)
        .where('id_list', isEqualTo: idList)
        .limit(30)
        .orderBy('id')
        .get();

    if (docs.docs.isNotEmpty) {
      for (var d in docs.docs) {
        listOfMap.add(d.data());
      }

      if (listOfMap.isEmpty) {
        return null;
      }

      var shareds = listOfMap.map((list) => SharedUserList.fromMap(list));

      shareds = shareds.where((s) => s.emailUser == email);
      if (shareds.isEmpty) {
        return null;
      }

      return shareds.first;
    }
  }

  Future<List<SharedUserList>> getAllMyShareds(String email) async {
    var shareds = <SharedUserList>[];

    var snap = await _firestoreService.firestore
        .collectionGroup(SharedUserList.tablename)
        .where('email_user', isEqualTo: email)
        .limit(30)
        .orderBy('id')
        .get();

    for (var doc in snap.docs) {
      shareds.add(SharedUserList.fromMap(doc.data()));
    }
    return shareds;
  }

  Future<List<SharedUserList>> getAllMySharedsByIdList(String idList) async {
    var shareds = <SharedUserList>[];

    var snap = await _firestoreService.firestore
        .collectionGroup(SharedUserList.tablename)
        .where('id_list', isEqualTo: idList)
        .limit(30)
        .orderBy('id')
        .get();

    for (var doc in snap.docs) {
      shareds.add(SharedUserList.fromMap(doc.data()));
    }
    return shareds;
  }

  Future<void> delete(SharedUserList shared) async {
    _firestoreService.firestore
        .collection(ListsByUser.tablename)
        .doc(shared.ownerIdAuthUser)
        .collection(SharedUserList.tablename)
        .doc(shared.id)
        .delete();
  }
}
