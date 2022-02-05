class ListsByUser {
  final String name;
  final String email;

  static String tablename = 'lists_by_user';

  ListsByUser({required this.name, required this.email});

  String tableName() => tablename;

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['name'] = name;
    map['email'] = email;

    return map;
  }

  factory ListsByUser.fromMap(Map<String, dynamic> data) {
    return ListsByUser(name: data['name'], email: data['email']);
  }
}
