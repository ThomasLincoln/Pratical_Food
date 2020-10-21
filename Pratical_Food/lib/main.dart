import 'package:flutter/material.dart';
import 'package:Pratical_Food/LoginPage.dart';
import 'package:Pratical_Food/CadastroPage.dart';
import 'package:Pratical_Food/MenuPage.dart';


void main() {
  runApp(AppTodo());
}

class AppTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Practical Food',
    // Parça isso aqui ta completamente diferente mas ta começando no msm lugar, eu precisei fazer isso pra conseguir ir de pagina em pagina
    initialRoute: '/',
    routes: {
      // o '/' é pra dar nome pras paginas pra navegar certinho e pow pow
      '/': (context) => LoginPage(),
      '/second': (context) => CadastroPage(),
      '/third': (context) => MenuPage(),
    });
  }
}

