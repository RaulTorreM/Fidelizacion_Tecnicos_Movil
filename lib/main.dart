import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/test_login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: TestLoginPage(),
      home: HomePage(),
    );
  }
}
