import 'package:game_space/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../constant.dart';
import '../models/api_response.dart';
import '../models/user.dart'; // Импортируем модель ApiResponse

  Future<List<dynamic>> fetchGames() async {
    final response = await http.get(Uri.parse('https://gamespacemobile.ru/public/api/games'));
    
    if (response.statusCode == 200) {
      // Если запрос успешен, распарсим JSON и вернем его
      return jsonDecode(response.body);
    } else {
      // Если запрос не удался, выведите сообщение об ошибке
      throw Exception('Failed to load games');
    }
  }
  Future<List<dynamic>> fetchTournaments() async{
    final response = await http.get(Uri.parse('http://gamespacemobile.ru/public/api/tournaments'));
    if (response.statusCode == 200) {
      // Если запрос успешен, распарсим JSON и вернем его
      return jsonDecode(response.body);
    } else {
      // Если запрос не удался, выведите сообщение об ошибке
      throw Exception('Failed to load tournaments');
    }
  }
Future<List<dynamic>> fetchTournamentsByGame(int gameId) async {
  final response = await http.get(Uri.parse('http://gamespacemobile.ru/public/api/games/$gameId/tournaments'));
  
  if (response.statusCode == 200) {
    // Если запрос успешен, распарсим JSON и вернем его
    return jsonDecode(response.body);
  } else {
    // Если запрос не удался, выведите сообщение об ошибке
    throw Exception('Failed to load tournaments');
  }
}
Future<ApiResponse> registerUser(String name, String email, String password, String confirmPassword) async {
  ApiResponse apiResponse = ApiResponse(); // Создаем объект ApiResponse
  try {
    final response = await http.post(
      Uri.parse(registerUrl), // Маршрут для регистрации
      headers: {'Accept': 'application/json'},
      body: {'name': name, 'email': email, 'password': password, 'password_confirmation': confirmPassword},
    );

    switch (response.statusCode) {
      case 200:
        // Если запрос успешен, присваиваем данные из ответа объекту ApiResponse
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        // Если получена ошибка 422, извлекаем ошибки из ответа и присваиваем их полю error
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        // Если получена ошибка 403, извлекаем сообщение об ошибке и присваиваем его полю error
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        // В случае других ошибок, присваиваем общее сообщение об ошибке
        apiResponse.error = 'Something went wrong';
        break;
    }
  } catch (e) {
    // Если произошла ошибка во время запроса, присваиваем сообщение о серверной ошибке
    apiResponse.error = 'Server error';
  }
  return apiResponse; // Возвращаем объект ApiResponse
}
Future<ApiResponse> fetchUserTournaments(int userId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('http://gamespacemobile.ru/public/api/user/$userId/tournaments'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}
Future<ApiResponse> loginUser(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try{
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {'Accept':'application/json'},
      body: {'email':email,'password':password}
    );
    switch(response.statusCode){
      case 200:
        print('Response Body: ${response.body}');
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  }
  catch(e){
    apiResponse.error = serverError;
  }
  return apiResponse;
}
Future<ApiResponse> getUserDetails() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(userURL),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    switch (response.statusCode) {
      case 200:
        print('Response Body: ${response.body}');
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> joinTournament(int tournamentId, int userId) async {
  ApiResponse apiResponse = ApiResponse(); // Создаем экземпляр ApiResponse

  try {
    final response = await http.post(
      Uri.parse('https://gamespacemobile.ru/public/api/tournaments/$tournamentId/participation'),
      headers: {'Accept': 'application/json'},
      body: {'user_id': '$userId', 'tournament_id': '$tournamentId'}, // Предполагаемый ID пользователя
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = {'success': 'Participation created successfully'}; // Успешный ответ от сервера
        break;
      case 409:
        apiResponse.error = 'Participation already exists'; // Ошибка при существующей записи
        break;
      case 500:
        apiResponse.error = 'Failed to add Participation'; // Ошибка сервера
        break;
      default:
        apiResponse.error = 'Something went wrong'; // Общая ошибка
        break;
    }
  } catch (e) {
    apiResponse.error = 'Server error'; // Ошибка при обращении к серверу
  }

  return apiResponse; // Возвращаем объект ApiResponse
}
Future<ApiResponse> fetchTournamentDetails(int tournamentId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.get(Uri.parse('$tournamentsUrl/$tournamentId'));

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 404:
        apiResponse.error = 'Tournament not found';
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}
//get token
Future<String> getToken() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}
//get user id
Future<int>getUserId() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('userId') ?? 0;
}
//logout
Future<bool>logout() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove('token');
}