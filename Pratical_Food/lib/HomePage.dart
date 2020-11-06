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
              if (!snapshot.hasData) return const Text('Carregando...');
              final int messageCount = snapshot.data.docs.length;
              return GridView.builder(
                itemCount: messageCount,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (_, int index){
                  final DocumentSnapshot document = snapshot.data.docs[index];
                  dynamic message1 = document.data()['nome'];
                  String nomeReceita = message1 != null ? message1.toString() : 'Sem receita';
                  dynamic message2 = document.data()['endereço'];
                  String endereco = message2 != null ? message2.toString() : 'Sem imagem';
                  return new Card(
                    child: new GestureDetector(
                      child: new GridTile(child: Column(
                        children: [Expanded(child: new Image.asset(endereco,fit: BoxFit.cover,)),
                        Padding(padding: EdgeInsets.only(top: 6, bottom: 6),
                        child: Text(nomeReceita),)                       
                        ]
                      )
                      //new Image.asset(endereco,height: 150,width: 100,)
                      ),
                      onTap: ()async {await showDialog(
                        context: context,
                        builder: (BuildContext context){
                          dynamic message3 = document.data()['modoDePreparo'];
                          String modoDePreparo = message3 != null ? message3.toString() : 'Sem descrição';
                          dynamic message5 = document.data()['ID'];
                          String id = message5 != null ? message5.toString() : 'sem ID';
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10, top: 30),
                            child: Dialog(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    //Row(
                                      //children: <Widget>[
                                        new Container(
                                            padding: const EdgeInsets.only(top: 30.0), //parte de cima da imagem
                                            child: new Image.asset(endereco,height: 150,width: 220,),
                                        ),
                                        new Padding(
                                          padding: EdgeInsets.all(20.0),
                                          child: Text(nomeReceita, style: TextStyle(fontSize: 20)), //tamanho do texto
                                        ),                                      
                                    //),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                      child: new Text(modoDePreparo, style: TextStyle(fontSize: 15), textAlign: TextAlign.justify),                                     
                                    ),
                                   
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance.collection('receitas').doc(id).collection('ingredientes').snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                                        if (!snapshot.hasData) return const Text('Carregando...');
                                        final int messageCountIngredientes = snapshot.data.docs.length; r
                                        
                                        return Container(child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,               
                                          itemCount: messageCountIngredientes,
                                          itemBuilder: (_, int index){
                                            final DocumentSnapshot document = snapshot.data.docs[index];
                                            dynamic ingrediente1 = document.data()['ID'];
                                            String idIngrediente = ingrediente1 != null ? ingrediente1.toString() : 'Sem ID';
                                            dynamic quantidade = document.data()['quantidade'];
                                            String quantidadeIngrediente = quantidade != null ? quantidade.toString() : 'Sem quantidade';
                                            dynamic unidade = document.data()['unidade'];
                                            String unidadeIngrediente = unidade != null ? unidade.toString() : 'Sem unidade';
                                            return Padding(
                                              padding: EdgeInsets.only(left: 20,right: 20),
                                              child: new Text(idIngrediente + " " + quantidadeIngrediente + " " + unidadeIngrediente));
                                          },
                                        ));
                                      }, 
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