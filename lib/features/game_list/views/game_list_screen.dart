import 'package:flutter/material.dart';
import 'package:game_space/features/game_list/widgets/game_list_widget.dart';
class GameListScreen extends StatefulWidget {
  const GameListScreen({super.key, required this.title});

  

  final String title;

  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        
        
        title: Text(widget.title),
        leading: const Icon(Icons.menu),
      ),
      body: ListView.separated(
        separatorBuilder: (context, i)=> Divider(),
        itemCount: 10,
        itemBuilder: (context,i){
          const gameName = 'DOTA 2';
          return const GameListTile( gameName: gameName);
        }
        ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}