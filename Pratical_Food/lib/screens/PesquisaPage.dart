import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class PesquisaPage extends StatefulWidget {
  @override
  _PesquisaPageState createState() => _PesquisaPageState();
}

class _PesquisaPageState extends State<PesquisaPage> {
  @override
  String filtro;
  Widget build(BuildContext context) {
    if(filtro == '') filtro = null;
    final guardarController = new TextEditingController();
    if (filtro != null){
      guardarController.text = filtro;
    }
    
    return new Column(
        children: <Widget>[
          Expanded(
            child: Container(
               child: Text('', textAlign: TextAlign.center, style: TextStyle (fontSize: 24)),
               margin: const EdgeInsets.symmetric(vertical: 0.0),
            )
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: '   Digite o nome de um ingrediente',
            ),
            controller: guardarController,
            onFieldSubmitted: (String filtr){
              setState(() {
                 filtro = guardarController.text;                
              });             
            },
          ),
          Expanded(
          flex: 4,
          child: StreamBuilder<QuerySnapshot>(
            stream: filtro != null ? FirebaseFirestore.instance.collection('ingredientes').where('nome', isGreaterThanOrEqualTo: filtro).where('nome', isLessThan: filtro + 'z').snapshots(): FirebaseFirestore.instance.collection('ingredientes').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData) return const Text('Carregando...');
              final int ingredienteCount = snapshot.data.docs.length;
              return ListView.builder(
                itemCount: ingredienteCount,
                itemBuilder: (_, index){
                  final DocumentSnapshot document = snapshot.data.docs[index];
                  dynamic message1 = document.data()['nome'];
                  String nomeIngrediente = message1 != null ? message1.toString() : 'Sem ingrediente!!!';
                  dynamic message5 = document.data()['ID'];
                  String id = message5 != null ? message5.toString() : 'sem ID';
                  return new Card(
                    child: Padding(padding: EdgeInsets.only(left: 10, top: 10, bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(nomeIngrediente)
                        ),
                        Expanded(
                          flex: 0, 
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: IconButton(tooltip: 'Adicionar à lista de compras', icon: Icon(Icons.add_shopping_cart),
                              onPressed:()async{
                                FirebaseUser user = await FirebaseAuth.instance.currentUser();
                                FirebaseFirestore.instance.collection('usuarios').doc(user.uid).collection('lista de compras').doc(id).set({
                                  'nome':nomeIngrediente,
                                  'ID':id
                                });
                              } 
                          )  
                        )
                      )
                      ],
                    )                   
                    )
                  );
                  },                 
                );
              }
            )
          )         
        ]
      );
         
  }
}