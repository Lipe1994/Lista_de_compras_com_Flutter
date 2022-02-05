import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lista_de_compras/core/models/entity.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);
  Future add(Entity entity) async {
    await _firestore.collection(entity.tableName()).add(entity.toMap());
  }

  FirebaseFirestore get firestore => _firestore;

  Future<Map<String, dynamic>?> getById(String tableName, String id) async {
    List<Map<String, dynamic>> map = [];

    var res =
        await _firestore.collection(tableName).where('id', isEqualTo: id).get();

    for (var doc in res.docs) {
      map.add(doc.data());
    }

    if (map.isEmpty) {
      return null;
    }

    return map.first;
  }

  Future<List<Map<String, dynamic>>> getAll(
      String tableName, String ownerEmail) async {
    List<Map<String, dynamic>> map = [];

    var res = await _firestore
        .collection(tableName)
        .where('owner_email', isEqualTo: ownerEmail)
        .get();

    for (var doc in res.docs) {
      map.add(doc.data());
    }

    return map;
  }
}
