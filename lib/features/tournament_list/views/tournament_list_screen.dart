import 'package:flutter/material.dart';


class TournamentListScreen extends StatefulWidget{
  const TournamentListScreen({super.key});
  @override
  State<TournamentListScreen> createState()=>_TournamentListScreen();
}
class _TournamentListScreen extends State<TournamentListScreen>{
  String? gameName;
  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is String, 'You must provide String args');
    
    gameName = args as String;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Text(gameName ?? '...')),
    );
  }
}