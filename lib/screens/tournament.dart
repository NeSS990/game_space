import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/api_response.dart';
import '../models/tournament.dart';
import '../models/user.dart'; // Добавлен импорт модели пользователя

class TournamentDetailScreen extends StatefulWidget {
  final int tournamentId;

  const TournamentDetailScreen({Key? key, required this.tournamentId}) : super(key: key);

  @override
  _TournamentDetailScreenState createState() => _TournamentDetailScreenState();
}

class _TournamentDetailScreenState extends State<TournamentDetailScreen> {
  late User _currentUser; // Добавлено поле для хранения информации о текущем пользователе

  @override
  void initState() {
    super.initState();
    _loadUserDetails(); // Загрузка информации о пользователе при инициализации экрана
  }

  void _loadUserDetails() async {
    try {
      ApiResponse response = await getUserDetails();
      if (response.error != null) {
        // Обработка ошибки, если есть
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${response.error}'),
          duration: Duration(seconds: 2),
        ));
      } else {
        // Установка информации о пользователе в состояние
        setState(() {
          _currentUser = response.data as User;
        });
      }
    } catch (e) {
      print('Error loading user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tournament Details'),
      ),
      body: FutureBuilder<ApiResponse>(
        future: fetchTournamentDetails(widget.tournamentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.error != null) {
            return Center(child: Text('Error: ${snapshot.data?.error ?? 'Unknown error'}'));
          } else {
            // Приведение типа
            final Map<String, dynamic> data = snapshot.data!.data as Map<String, dynamic>;
            final tournament = Tournament.fromJson(data);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tournament.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Description: ${tournament.description}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _joinTournament(widget.tournamentId, _currentUser.id); // Передаем ID пользователя
                    },
                    child: Text('Join Tournament'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _joinTournament(int tournamentId, int userId) async {
    ApiResponse response = await joinTournament(tournamentId, userId); // Передаем ID пользователя

    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${response.error}'),
        duration: Duration(seconds: 2),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Successfully joined the tournament'),
        duration: Duration(seconds: 2),
      ));
    }
  }
}
