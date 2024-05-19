// profile_screen.dart

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/api_response.dart';
import '../models/user.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _currentUser;
  List<dynamic> _userTournaments = [];

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    ApiResponse response = await getUserDetails();
    if (response.data != null && response.data is User) {
      setState(() {
        _currentUser = response.data as User;
      });
      _loadUserTournaments(_currentUser!.id);
    } else {
      // Handle error or redirect to login
    }
  }

  void _loadUserTournaments(int userId) async {
    ApiResponse response = await fetchUserTournaments(userId);
    if (response.data != null) {
      setState(() {
        _userTournaments = response.data as List<dynamic>;
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: _currentUser == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${_currentUser!.name}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Email: ${_currentUser!.email}', // Отображение email
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Tournaments:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _userTournaments.length,
                      itemBuilder: (BuildContext context, int index) {
                        final tournament = _userTournaments[index];
                        return ListTile(
                          title: Text(tournament['title']),
                          subtitle: Text('Date: ${tournament['DateStart']}'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
