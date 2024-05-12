// main.dart
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'tournament_list.dart';
import 'user_register.dart';
import 'user_login.dart'; // Импортируем файл с экраном авторизации
import 'package:shared_preferences/shared_preferences.dart'; // Импортируем пакет для работы с SharedPreferences

void main() {
  runApp(const GameApp());
}

class GameApp extends StatelessWidget {
  const GameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game App',
      theme: ThemeData.dark(), // Используем темную тему
      home: const BottomNav(), // Устанавливаем BottomNav как домашний экран
    );
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  late bool _isAuthenticated; // Флаг, указывающий на авторизацию пользователя

  @override
  void initState() {
    super.initState();
    _checkAuthStatus(); // Проверяем статус авторизации при инициализации виджета
  }

  // Функция для проверки статуса авторизации
  void _checkAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isAuthenticated = prefs.getBool('isAuthenticated') ?? false; // Получаем статус из SharedPreferences, по умолчанию false
    setState(() {
      _isAuthenticated = isAuthenticated;
    });
  }

  // Функция для изменения выбранного индекса
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game App'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          GameList(), // Экран с играми
          _isAuthenticated ? const GameList() : const RegisterOrLoginScreen(), // Если пользователь авторизован, показываем экран с играми, иначе - экран регистрации или авторизации
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Register/Login',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}

class GameList extends StatelessWidget {
  const GameList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchGames(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              var game = snapshot.data?[index];
              return Card(
                margin: const EdgeInsets.all(10.0),
                elevation: 5.0,
                child: ListTile(
                  leading: game['image'] != null ? Image.network(game['image']) : Icon(Icons.gamepad),
                  title: Text(
                    game['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(game['description']),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    int gameId = game['id'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TournamentList(gameId: gameId),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class RegisterOrLoginScreen extends StatelessWidget {
  const RegisterOrLoginScreen({Key? key}) : super(key: key); // Добавляем ключ

  @override
  Widget build(BuildContext context) {
    return const LoginScreen(); // Показываем экран авторизации по умолчанию
  }
}

