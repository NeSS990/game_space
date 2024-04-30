import 'package:game_space/features/game_list/game_list.dart';
import 'package:game_space/features/tournament_list/tournament_list.dart';
 
final routes = {
        '/':(context) => const GameListScreen(title: 'Game Space'),
        '/gametournaments':(context)=> const TournamentListScreen(),
      };