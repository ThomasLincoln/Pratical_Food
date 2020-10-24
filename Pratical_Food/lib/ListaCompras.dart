import 'package:flutter/material.dart';

class ListaCompras extends StatefulWidget {
  @override
  _ListaComprasState createState() => _ListaComprasState();

}

class _ListaComprasState extends State<ListaCompras> {
  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A', 'B', 'C'];

    return new Column(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Container(
              child: Text('Lista de Compras', style: TextStyle (fontSize: 24), textAlign: TextAlign.right),
              margin: const EdgeInsets.symmetric(vertical: 40.0),
            )
          ),
          Expanded(child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  child: (Text('Entry ${entries[index]}')),
                );
              }
            )
            )
        ]
      );
  }

  
}