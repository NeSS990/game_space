import 'package:flutter/material.dart';
import 'api_service.dart'; // Подключаем файл с функцией fetchTournamentsByGame

class TournamentList extends StatelessWidget {
  final int gameId;

  const TournamentList({Key? key, required this.gameId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tournaments for Game $gameId'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchTournamentsByGame(gameId), // Получаем турниры для выбранной игры
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Если есть данные, отображаем список турниров
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data?[index]['title']),
                  // Другие поля, которые вы хотите отобразить для каждого турнира
                );
              },
            );
          } else if (snapshot.hasError) {
            // Если произошла ошибка, отобразим ее
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          // Показываем индикатор загрузки, пока данные загружаются
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
