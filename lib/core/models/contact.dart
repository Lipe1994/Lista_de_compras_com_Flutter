import 'package:lista_de_compras/core/models/entity.dart';

class Contact extends Entity {
  final String name;
  final String email;
  final String ownerEmail;
  final DateTime createdAt;
  final String? telephone;
  final String? urlImage;

  Contact(
      {String? id,
      required this.name,
      required this.ownerEmail,
      required this.email,
      required this.telephone,
      required this.urlImage,
      required this.createdAt})
      : super(id);

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['name'] = name;
    map['owner_email'] = ownerEmail;
    map['email'] = email;
    map['created_at'] = createdAt.toIso8601String();
    map['telephone'] = telephone;
    map['urlImage'] = urlImage;

    return map;
  }

  factory Contact.fromMap(Map<String, dynamic> data) {
    return Contact(
      id: data['id'],
      name: data['name'],
      ownerEmail: data['owner_email'],
      email: data['email'],
      createdAt: DateTime.parse(data['created_at']),
      telephone: data['telephone'],
      urlImage: data['urlImage'],
    );
  }

  static String tablename = 'contact';

  @override
  tableName() => tablename;
}
