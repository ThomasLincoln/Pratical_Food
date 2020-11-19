import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListaCompras extends StatefulWidget {
  @override
  _ListaComprasState createState() => _ListaComprasState();

}

class _ListaComprasState extends State<ListaCompras> {
  @override
  Widget build(BuildContext context) {
    return new Column(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Container(
              child: Text('Lista de Compras', style: TextStyle (fontSize: 24), textAlign: TextAlign.right),
              margin: const EdgeInsets.symmetric(vertical: 40.0),
            )
          ),
          Expanded(child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('usuarios').doc('Jose').collection('lista de compras').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData) return const Text('Carregando...');
              final int ingredienteCount = snapshot.data.docs.length;
              return ListView.builder(
                itemCount: ingredienteCount,
                itemBuilder: (_, index){
                  final DocumentSnapshot document = snapshot.data.docs[index];
                  dynamic message1 = document.data()['nome'];
                  String nomeIngrediente = message1 != null ? message1.toString() : 'Carrinho vazio';
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
                            child: IconButton(
                              icon: Icon(Icons.delete_outline),
                              tooltip: 'Remover da lista de compras',
                              onPressed: (){
                                FirebaseFirestore.instance.collection('usuarios').doc('Jose').collection('lista de compras').doc(id).delete();
                              })
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