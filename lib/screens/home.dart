import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_space/screens/games.dart';
import '../services/api_service.dart';
import '../models/api_response.dart';
import 'login.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF511E97),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SvgPicture.asset(
                'assets/svg/logo.svg',
                height: 32,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'GAME SPACE',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'ОТКРОЙ ВСЕЛЕННУЮ ПОБЕД',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GamesScreen()),
                            );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF511E97),
                onPrimary: Colors.white,
              ),
              child: Text('Принять участие', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Действия при нажатии на кнопку "Команды"
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF511E97),
                onPrimary: Colors.white,
              ),
              child: Text('Команды', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            FutureBuilder(
              future: getUserDetails(),
              builder: (BuildContext context, AsyncSnapshot<ApiResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox.shrink();
                } else {
                  if (snapshot.hasError || snapshot.data?.error != null) {
                    return Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF511E97),
                            onPrimary: Colors.white,
                          ),
                          child: Text('Авторизация', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Действия при нажатии на кнопку "Профиль"
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF511E97),
                            onPrimary: Colors.white,
                          ),
                          child: Text('Профиль', style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            logout(); // Вызов функции logout
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF511E97),
                            onPrimary: Colors.white,
                          ),
                          child: Text('Выйти', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
