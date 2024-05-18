import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/api_response.dart';
import '../models/tournament.dart';

class TournamentDetailScreen extends StatelessWidget {
  final int tournamentId;

  const TournamentDetailScreen({Key? key, required this.tournamentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tournament Details'),
      ),
      body: FutureBuilder<ApiResponse>(
        future: fetchTournamentDetails(tournamentId),
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
                  // Add other fields as needed
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
