import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  String? name;
  String? authUserId;
  String? urlImage;
  String? email;

  Preferences.init(
      {required this.name,
      required this.authUserId,
      required this.urlImage,
      required this.email});

  Preferences();

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['name'] = name;
    map['authUserId'] = authUserId;
    map['urlImage'] = urlImage;
    map['email'] = email;
    return map;
  }

  factory Preferences.fromMap(Map<String, dynamic> data) {
    return Preferences.init(
        name: data['name'],
        authUserId: data['authUserId'],
        urlImage: data['urlImage'],
        email: data['email']);
  }

  Future setPreferences(Preferences preferences) async {
    final prefs = await SharedPreferences.getInstance();
    var data = json.encode(preferences.toMap());
    return await prefs.setString("preferences", data);
  }

  Future<Preferences?> getPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getString("preferences");

    if (data == null) {
      return null;
    }
    return Preferences.fromMap(json.decode(data));
  }

  Future<bool?> clear() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}
