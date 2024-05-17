import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../services/api_service.dart'; // Импорт функции fetchTournamentsByGame

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
          return ListTile(
            title: Text(tournaments[index]['title']),
            subtitle: Text('Date: ${tournaments[index]['DateStart']}'),
            onTap: () {
              // Действия при нажатии на турнир
            },
          );
        },
      ),
    );
  }
}
