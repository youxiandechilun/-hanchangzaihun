import 'package:dome2/pages/home_page.dart';
import 'package:dome2/pages/login_page.dart';
import 'package:flutter/material.dart';

import 'services/login_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final LoginService loginService = LoginService();
  final bool isLoggedIn = await loginService.checkLoginStatus();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn ? HomePage() : LoginPage(),
    );
  }
}