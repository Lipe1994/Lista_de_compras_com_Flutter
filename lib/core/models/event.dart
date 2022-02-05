import 'package:lista_de_compras/core/models/entity.dart';

class Event extends Entity {
  final String entityName;
  final String idTable;
  final bool sended;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Event(
      {String? id,
      required this.entityName,
      required this.idTable,
      this.sended = false,
      required this.createdAt,
      required this.updatedAt})
      : super(id);

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['entity_name'] = entityName;
    map['id_table'] = idTable;
    map['sended'] = sended ? 1 : 0;
    map['updated_at'] = updatedAt?.toIso8601String();
    map['created_at'] = createdAt.toIso8601String();
    return map;
  }

  factory Event.fromMap(Map<String, dynamic> data) {
    return Event(
      id: data['id'],
      entityName: data['entity_name'],
      idTable: data['id_table'],
      sended: data['sended'] == 1 ? true : false,
      updatedAt: data['updated_at'] != null
          ? DateTime.parse(data['updated_at'])
          : null,
      createdAt: DateTime.parse(data['created_at']),
    );
  }

  static String tablename = 'event';

  @override
  tableName() => tablename;
}
