import 'package:flutter/material.dart';
final darkTheme = ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 31, 31, 31),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.amber),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 31, 31, 31),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            
          ),iconTheme: IconThemeData(
            color: Colors.white,
          )
        ),
        dividerTheme: const DividerThemeData(
          color: Colors.white24,
        ),
        useMaterial3: true,
        listTileTheme: const ListTileThemeData(iconColor: Colors.white),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            ),
          labelSmall: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ), 
        )
      );