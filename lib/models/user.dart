import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int id;
  final String name;
  final String email; // Добавлено поле email
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email, // Добавлено поле email
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'] as int,
      name: json['user']['name'] as String,
      email: json['user']['email'] as String, // Добавлено поле email
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email, // Добавлено поле email
      'token': token,
    };
  }

  static Future<void> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', user.id);
    prefs.setString('name', user.name);
    prefs.setString('email', user.email); // Добавлено поле email
    prefs.setString('token', user.token);
  }
}
