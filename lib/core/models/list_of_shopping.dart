import 'package:lista_de_compras/core/models/entity.dart';
import 'package:lista_de_compras/core/models/item_list.dart';

class ListOfShopping extends Entity {
  final String name;
  final String note;
  final String ownerEmail;
  final String ownerName;
  final String ownerIdAuthUser;

  final DateTime createdAt;
  final DateTime? updatedAt;
  final String?
      idUpdateCurrentUser; //somente para informar quem está fazendo update

  bool? isSharedNotAcepted;

  List<ItemList> itemList;

  ListOfShopping(
      {String? id,
      required this.name,
      this.idUpdateCurrentUser,
      required this.ownerName,
      required this.note,
      required this.ownerIdAuthUser,
      required this.ownerEmail,
      required this.createdAt,
      this.updatedAt,
      this.isSharedNotAcepted = false,
      List<ItemList>? itemList})
      : itemList = itemList ?? [],
        super(id);

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['id_update_current_user'] = idUpdateCurrentUser;
    map['name'] = name;
    map['owner_name'] = ownerName;
    map['note'] = note;
    map['owner_id_auth_user'] = ownerIdAuthUser;
    map['owner_email'] = ownerEmail;
    map['updated_at'] = updatedAt?.toIso8601String();
    map['created_at'] = createdAt.toIso8601String();

    return map;
  }

  factory ListOfShopping.fromMap(Map<String, dynamic> data) {
    return ListOfShopping(
      id: data['id'],
      name: data['name'],
      idUpdateCurrentUser: data['id_update_current_user'],
      ownerIdAuthUser: data['owner_id_auth_user'],
      ownerName: data['owner_name'],
      note: data['note'],
      ownerEmail: data['owner_email'],
      updatedAt: data['updated_at'] != null
          ? DateTime.parse(data['updated_at'])
          : null,
      createdAt: DateTime.parse(data['created_at']),
      itemList: data['item_list'] != null
          ? (data['item_list'] as List).map((e) => ItemList.fromMap(e)).toList()
          : null,
    );
  }

  static String tablename = 'list_of_shopping';

  @override
  String tableName() => tablename;
}
