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
                    child: new GestureDetector(
                      child: new GridTile(child: new Image.asset("assets/ednaldo.jpg",height: 20,width: 20,)),
                      onTap: ()async {await showDialog(
                        context: context,
                        builder: (BuildContext context){
                          dynamic message3 = document.data()['modoDePreparo'];
                          String modoDePreparo = message3 != null ? message3.toString() : 'Sem descrição amigão';
                          return Padding(
                            padding: EdgeInsets.only(bottom: 25.2, top: 25.2),
                            child: Dialog(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        new Container(
                                            padding: const EdgeInsets.all(2.0),
                                            child: new Image.asset("assets/ednaldo.jpg",height: 20,width: 20,),
                                        ),
                                        new Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Text(nomeReceita, style: TextStyle(fontSize: 10)),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: new Text(modoDePreparo, style: TextStyle(fontSize: 10)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        );
                      }
                    )
                  );
                }
              );
            },
          )
          )
        ]
      );
  }
}