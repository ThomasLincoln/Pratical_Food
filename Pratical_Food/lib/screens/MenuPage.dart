import 'package:Pratical_Food/screens/FavoritosPage.dart';
import 'package:Pratical_Food/HomePage.dart';
import 'package:Pratical_Food/screens/ListaCompras.dart';
import 'package:Pratical_Food/screens/PesquisaPage.dart';
import 'package:Pratical_Food/screens/FeedbackPage.dart';
import 'package:flutter/material.dart';
import 'package:Pratical_Food/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Pratical_Food/services/auth.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }

// flutter run -t lib/pages/main.dart
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final AuthService _auth = AuthService();

  int _selectedIndex = 0;
  //static const TextStyle optionStyle =
  //    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _children = [
    HomePage(),
    ListaCompras(),
    FavoritosPage(),
    PesquisaPage(),
    FeedbackPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          backgroundColor: Colors.yellow[600],
          title: const Text('Pratical Food',
              style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Deslogar'),
                onPressed: () async {
                  await _auth.signOut();
                })
          ]),
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Carrinho'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favoritos'),
          ),
          BottomNavigationBarItem(
            icon:
             Icon(Icons.search),
            title: Text('Ingredientes', style: TextStyle(fontSize: 13)),
          ),    
          BottomNavigationBarItem(
            icon: 
            Icon(Icons.feedback),
            title: Text('Feedback')
          )      
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
