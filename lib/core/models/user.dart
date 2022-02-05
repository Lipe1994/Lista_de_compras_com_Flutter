import 'package:lista_de_compras/core/models/entity.dart';

class User extends Entity {
  final String name;
  final String email;
  final DateTime createdAt;
  final String? telephone;
  final String? urlImage;

  User(
      {String? id,
      required this.name,
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
    map['email'] = email;
    map['created_at'] = createdAt.toIso8601String();
    map['telephone'] = telephone;
    map['urlImage'] = urlImage;

    return map;
  }

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      createdAt: DateTime.parse(data['created_at']),
      telephone: data['telephone'],
      urlImage: data['urlImage'],
    );
  }

  static String tablename = 'user';

  @override
  tableName() => tablename;
}
