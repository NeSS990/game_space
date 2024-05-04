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
        future: fetchTournamentsByGame(gameId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                var tournament = snapshot.data?[index];
                return Card(
                  margin: const EdgeInsets.all(10.0),
                  elevation: 5.0,
                  child: ListTile(
                    title: Text(tournament['title']),
                    subtitle: Text(tournament['description']),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TournamentDetail(tournament: tournament),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class TournamentDetail extends StatelessWidget {
  final dynamic tournament;

  const TournamentDetail({Key? key, required this.tournament}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tournament['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Название турнира: ${tournament['title']}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Описание: ${tournament['description']}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Дата начала турнира: ${tournament['DateStart']}',
              style: TextStyle(fontSize: 16.0),
            ),
            // Добавьте другие поля, которые хотите отобразить для турнира
          ],
        ),
      ),
    );
  }
}



