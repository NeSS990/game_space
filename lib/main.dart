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

