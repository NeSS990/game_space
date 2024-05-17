import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'game_tournaments.dart'; // Импорт функции fetchGames из вашего файла api_service.dart

class GamesScreen extends StatefulWidget {
  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  List<dynamic> games = [];

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  void _loadGames() async {
    try {
      List<dynamic> fetchedGames = await fetchGames();
      setState(() {
        games = fetchedGames;
      });
    } catch (e) {
      print('Error fetching games: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Games'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: games.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TournamentsScreen(gameId: games[index]['id']),
      ),
    );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF511E97),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF3EC5FF),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          games[index]['title'],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
