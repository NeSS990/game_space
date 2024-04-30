import 'package:flutter/material.dart';
import 'api_service.dart';

class GameList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchGames(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Если есть данные, отобразим список игр
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data?[index]['title']),
                subtitle: Text(snapshot.data?[index]['description']),
                // Другие поля, которые вы хотите отобразить
              );
            },
          );
        } else if (snapshot.hasError) {
          // Если произошла ошибка, отобразим ее
          return Text("${snapshot.error}");
        }

        // Показываем индикатор загрузки, пока данные загружаются
        return CircularProgressIndicator();
      },
    );
  }
}
