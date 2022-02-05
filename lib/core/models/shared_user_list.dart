import 'package:lista_de_compras/core/models/entity.dart';

class SharedUserList extends Entity {
  final String emailUser;
  final String idList;
  final String ownerIdAuthUser;
  final bool? acepted;
  final DateTime createdAt;
  final DateTime? updatedAt;

  SharedUserList(
      {String? id,
      required this.emailUser,
      required this.idList,
      required this.ownerIdAuthUser,
      this.acepted,
      this.updatedAt,
      required this.createdAt})
      : super(id);

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['owner_id_auth_user'] = ownerIdAuthUser;
    map['email_user'] = emailUser;
    map['id_list'] = idList;
    map['acepted'] = acepted == true
        ? 1
        : acepted == false
            ? 0
            : null;
    map['updated_at'] = updatedAt?.toIso8601String();
    map['created_at'] = createdAt.toIso8601String();
    return map;
  }

  factory SharedUserList.fromMap(Map<String, dynamic> data) {
    return SharedUserList(
      id: data['id'],
      emailUser: data['email_user'],
      ownerIdAuthUser: data['owner_id_auth_user'],
      idList: data['id_list'],
      acepted: data['acepted'] == 1
          ? true
          : data['acepted'] == 0
              ? false
              : null,
      updatedAt: data['updated_at'] != null
          ? DateTime.parse(data['updated_at'])
          : null,
      createdAt: DateTime.parse(data['created_at']),
    );
  }

  static String tablename = 'shared_user_list';

  @override
  tableName() => tablename;
}
