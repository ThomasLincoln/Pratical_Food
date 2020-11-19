import 'package:cloud_firestore/cloud_firestore.dart';
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
            stream: FirebaseFirestore.instance.collection('ingredientes').where('ID', isEqualTo: filtro).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData) return const Text('Carregando...');
              final int ingredienteCount = snapshot.data.docs.length;
              return ListView.builder(
                itemCount: ingredienteCount,
                itemBuilder: (_, index){
                  final DocumentSnapshot document = snapshot.data.docs[index];
                  dynamic message1 = document.data()['ID'];
                  String nomeIngrediente = message1 != null ? message1.toString() : 'Sem ingrediente!!!';
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
                            child: Icon(Icons.add_shopping_cart),
                          )  
                        )
                        // new Container(
                        //   child: Text(nomeIngrediente, textAlign: TextAlign.left,),
                        // ),
                        // new Container(
                        //   child: Icon(Icons.add_shopping_cart),
                        // )
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