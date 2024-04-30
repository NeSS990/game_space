import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class GameListTile extends StatelessWidget {
  const GameListTile({
    super.key,
    
    required this.gameName,
  });

  
  final String gameName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
    leading: SvgPicture.asset('assets/svg/dota_2.svg', height: 25,width: 25,),
    title: Text('DOTA 2', style:theme.textTheme.labelSmall,),
    subtitle: Text('MOBA Игра 5x5 ', style: theme.textTheme.labelSmall,),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap:(){
      Navigator.of(context).pushNamed('/gametournaments', arguments: gameName);
    },
            );
  }
}