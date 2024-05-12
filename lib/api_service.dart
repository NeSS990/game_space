import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> fetchGames() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8001/api/games'));
  
  if (response.statusCode == 200) {
    // Если запрос успешен, распарсим JSON и вернем его
    return jsonDecode(response.body);
  } else {
    // Если запрос не удался, выведите сообщение об ошибке
    throw Exception('Failed to load games');
  }
}
Future<List<dynamic>> fetchTournamentsByGame(int gameId) async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8001/api/games/$gameId/tournaments'));
  
  if (response.statusCode == 200) {
    // Если запрос успешен, распарсим JSON и вернем его
    return jsonDecode(response.body);
  } else {
    // Если запрос не удался, выведите сообщение об ошибке
    throw Exception('Failed to load tournaments');
  }
}
Future<Map<String, dynamic>> registerUser(String name, String email, String password) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8001/api/register'), // Маршрут для регистрации
    body: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password, // Подтверждение пароля
    },
  );
  
  if (response.statusCode == 200) {
    // Если запрос успешен, распарсим JSON и вернем его
    return jsonDecode(response.body);
  } else {
    // Если запрос не удался, выведите сообщение об ошибке
    throw Exception('Failed to register user');
  }
}
Future<Map<String, dynamic>> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8001/api/login'), // Маршрут для авторизации
    body: {
      'email': email,
      'password': password,
    },
  );
  
  if (response.statusCode == 200) {
    // Если запрос успешен, распарсим JSON и вернем его
    return jsonDecode(response.body);
  } else {
    // Если запрос не удался, выведите сообщение об ошибке
    throw Exception('Failed to login user');
  }
}