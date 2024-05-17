import 'package:flutter/material.dart';
import 'package:game_space/screens/home.dart';

import 'screens/loading.dart';

void main() {
  runApp(GameApp());
}

class GameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFBE80FF), // Задний фон приложения
      ),
    );
  }
}
