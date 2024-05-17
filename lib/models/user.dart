import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int id;
  final String name;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
  return User(
    id: json['user']['id'] as int,
    name: json['user']['name'] as String,
    token: json['token'] as String,
  );
}


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'token': token,
    };
  }

  static Future<void> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', user.id);
    prefs.setString('name', user.name);
    prefs.setString('token', user.token);
  }
}
