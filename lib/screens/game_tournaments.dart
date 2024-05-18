import 'package:flutter/material.dart';
import '../screens/tournament.dart'; // Импорт нового экрана
import '../services/api_service.dart';

class TournamentsScreen extends StatefulWidget {
  final int gameId;

  TournamentsScreen({required this.gameId});

  @override
  _TournamentsScreenState createState() => _TournamentsScreenState();
}

class _TournamentsScreenState extends State<TournamentsScreen> {
  List<dynamic> tournaments = [];

  @override
  void initState() {
    super.initState();
    _loadTournaments();
  }

  void _loadTournaments() async {
    try {
      List<dynamic> fetchedTournaments = await fetchTournamentsByGame(widget.gameId);
      setState(() {
        tournaments = fetchedTournaments;
      });
    } catch (e) {
      print('Error fetching tournaments: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tournaments'),
      ),
      body: ListView.builder(
        itemCount: tournaments.length,
        itemBuilder: (BuildContext context, int index) {
          final tournament = tournaments[index]; // Получаем текущий турнир
          return ListTile(
            title: Text(tournament['title']),
            subtitle: Text('Date: ${tournament['DateStart']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TournamentDetailScreen(
                    tournamentId: tournament['id'] as int, // Приведение типа к int
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
