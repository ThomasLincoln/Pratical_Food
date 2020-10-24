import 'package:Pratical_Food/FavoritosPage.dart';
import 'package:Pratical_Food/HomePage.dart';
import 'package:Pratical_Food/ListaCompras.dart';
import 'package:flutter/material.dart';

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
  int _selectedIndex = 0;
  //static const TextStyle optionStyle =
  //    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _children = [
    HomePage(),   
    ListaCompras(),  
    FavoritosPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        title: const Text('Página Inicial', style: TextStyle(color: Colors.black)),     
      ),
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Lista de Compras'),
          ),
          BottomNavigationBarItem(
            icon:
             Icon(Icons.favorite),
            title: Text('Favoritos'),
          ),         
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
