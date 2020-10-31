import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//qaolquer comentario ai (entendi)

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      Expanded(
          flex: 0,
          child: Container(
            child: Text('Receitas',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
            margin: const EdgeInsets.symmetric(vertical: 40.0),
          )),
      Expanded(
          child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(30, (index) {
                return new Card(
                  elevation: 10.0,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                  child: new Container(
                      child: new Text(
                    "Comida",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  )),
                );
              })))
    ]);
  }
}
