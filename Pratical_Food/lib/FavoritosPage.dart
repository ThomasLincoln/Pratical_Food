import 'package:flutter/material.dart';


class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  @override
  Widget build(BuildContext context) {
    return new Row(
        children: <Widget>[
          Expanded(
            child: Container(
               child: Text('Favoritos', textAlign: TextAlign.center, style: TextStyle (fontSize: 24)),
               margin: const EdgeInsets.symmetric(vertical: 40.0),
            )
          )
        ]
      );
  }
}