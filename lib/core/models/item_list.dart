import 'package:lista_de_compras/core/models/entity.dart';

class ItemList extends Entity {
  final String name;
  final String note;
  final double price;
  final int quantity;
  final String? urlImage;
  final bool checked;
  final String idList;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String ownerIdAuthUser;

  bool markedToRemove = false;

  ItemList({
    String? id,
    required this.idList,
    required this.name,
    required this.note,
    required this.ownerIdAuthUser,
    this.quantity = 1,
    this.price = 0,
    this.urlImage,
    this.checked = false,
    required this.createdAt,
    this.updatedAt,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['owner_id_auth_user'] = ownerIdAuthUser;
    map['id_list'] = idList;
    map['url_image'] = urlImage;
    map['name'] = name;
    map['note'] = note;
    map['price'] = price;
    map['quantity'] = quantity;
    map['checked'] = checked ? 1 : 0;
    map['updated_at'] = updatedAt?.toIso8601String();
    map['created_at'] = createdAt.toIso8601String();

    return map;
  }

  factory ItemList.fromMap(Map<String, dynamic> data) {
    return ItemList(
      id: data['id'],
      ownerIdAuthUser: data['owner_id_auth_user'],
      idList: data['id_list'],
      urlImage: data['url_image'],
      name: data['name'],
      note: data['note'],
      price: double.tryParse(data['price'].toString()) ?? 0.0,
      quantity: int.tryParse(data['quantity'].toString()) ?? 0,
      checked: data['checked'] == 1 ? true : false,
      updatedAt: data['updated_at'] != null
          ? DateTime.parse(data['updated_at'])
          : null,
      createdAt: DateTime.parse(data['created_at']),
    );
  }

  static String tablename = 'item_list';

  @override
  String tableName() => tablename;
}
