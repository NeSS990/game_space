import 'package:flutter/material.dart';
import 'package:game_space/screens/home.dart';
import 'package:game_space/services/api_service.dart';
import '../models/api_response.dart';
import '../models/user.dart'; // Импортируем наш API сервис
import 'register.dart'; // Импортируем экран регистрации

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Контроллеры для полей ввода
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Функция для обработки нажатия на кнопку "Войти"
  void _login() async {
    String email = emailController.text;
    String password = passwordController.text;

    // Вызываем метод для входа пользователя
    ApiResponse response = await loginUser(email, password);

    // Проверяем результат запроса
    if (response.error == null) {
      // Если ошибок нет, сохраняем пользователя и перенаправляем на экран Home
      User user = response.data as User;
      await User.saveUser(user);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      // Если есть ошибки, отображаем сообщение об ошибке
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text('Go to Register'),
            ),
          ],
        ),
      ),
    );
  }
}
