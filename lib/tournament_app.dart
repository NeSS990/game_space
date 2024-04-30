import 'package:flutter/material.dart';

import 'router/router.dart';
import 'theme/theme.dart';
class TournamentApp extends StatelessWidget {
  const TournamentApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: darkTheme,
      routes: routes,
      
    );
  }
}