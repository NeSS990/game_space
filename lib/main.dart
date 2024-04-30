import 'package:flutter/material.dart';
import 'api_service.dart'; // Подключаем файл с функцией fetchGames
import 'tournament_list.dart'; // Подключаем файл со списком турниров

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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Game List'),
        ),
        body: GameList(), // Добавляем виджет GameList в качестве основного контента
      ),
    );
  }
}

class GameList extends StatelessWidget {
  const GameList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchGames(), // Используем функцию fetchGames из api_service.dart
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Если есть данные, отобразим список игр
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(10.0),
                elevation: 5.0,
                child: ListTile(
                  title: Text(
                    snapshot.data?[index]['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(snapshot.data?[index]['description']),
                  // Добавляем стрелочку справа для перехода
                  trailing: Icon(Icons.arrow_forward),
                  // Переходим на экран с подробной информацией об игре при нажатии
                  onTap: () {
                    // Получаем ID выбранной игры
                    int gameId = snapshot.data?[index]['id'];
                    // Переходим на экран с турнирами для выбранной игры
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
          // Если произошла ошибка, отобразим ее
          return Text("${snapshot.error}");
        }

        // Показываем индикатор загрузки, пока данные загружаются
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
