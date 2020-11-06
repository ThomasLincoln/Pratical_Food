import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//qaolquer comentario ai

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    
    return new Column(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Container(
              child: Text('Receitas', textAlign: TextAlign.center, style: TextStyle (fontSize: 24)),
              margin: const EdgeInsets.symmetric(vertical: 40.0),
            )
          ),
          Expanded(child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('receitas').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData) return const Text('Carregando');
              final int messageCount = snapshot.data.docs.length;
              return GridView.builder(
                itemCount: messageCount,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (_, int index){
                  final DocumentSnapshot document = snapshot.data.docs[index];
                  dynamic message1 = document.data()['nome'];
                  String nomeReceita = message1 != null ? message1.toString() : 'Sem receita amigao';
                  return new Card(
                    child: Text(nomeReceita));
                }
              );
            },
          )
          )
        ]
      );
  }
}