import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//qaolquer comentario ai

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection('receitas').doc('nome').set({
      'nome': 'pinto',
      'mano': 'queisso',
    });
    return new Column(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Container(
              child: Text('Receitas', textAlign: TextAlign.center, style: TextStyle (fontSize: 24)),
              margin: const EdgeInsets.symmetric(vertical: 40.0),
            )
          ),
          Expanded(child: GridView.count(
              crossAxisCount: 2,
            children: List.generate(30, (index) {
              return new Card(
                elevation: 10.0,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0)
                ),
                child: new Container (child: new Text("Comida", style: TextStyle(fontSize:18), textAlign: TextAlign.center,)),
              );
            })
         )          )
        ]
      );
  }
}