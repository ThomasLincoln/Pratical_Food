import 'package:flutter/material.dart';
import 'package:Pratical_Food/pages/LoginPage.dart';

void main() {
  runApp(AppTodo());
}

class AppTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Practical Food',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: LoginPage(),
    );
  }
}
