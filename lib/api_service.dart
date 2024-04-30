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