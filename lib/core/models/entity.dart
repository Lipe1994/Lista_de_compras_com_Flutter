import 'package:uuid/uuid.dart';

abstract class Entity {
  final String id;

  Entity(String? id) : id = id ?? const Uuid().v4();

  String tableName();
  Map<String, dynamic> toMap();
}
