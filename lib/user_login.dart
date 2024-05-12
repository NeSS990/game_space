// user_login.dart
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'user_register.dart';
import 'main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _login(context); // Передаем контекст для навигации
              },
              child: Text('Login'),
            ),
            SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(), // Переход на экран регистрации
                  ),
                );
              },
              child: Text('Завести аккаунт'), // Добавим кнопку "Завести аккаунт"
            ),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) async { // Добавляем параметр context
  final String email = _emailController.text;
  final String password = _passwordController.text;

  try {
    // Отправляем запрос на авторизацию
    final response = await loginUser(email, password);
    
    // Если авторизация успешна, сохраняем токен и переходим на главный экран
    // Вам нужно добавить логику для сохранения токена и перехода на главный экран
    print('Login successful. Token: ${response['token']}');
    Navigator.pushAndRemoveUntil( // Переходим на главный экран и удаляем все предыдущие экраны
      context,
      MaterialPageRoute(
        builder: (context) => const GameApp(), // Переход на главный экран
      ),
      (route) => false, // Удаляем все предыдущие экраны
    );
  } catch (e) {
    // Если произошла ошибка, отобразим сообщение
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Error'),
          content: Text('Failed to login: $e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

}
