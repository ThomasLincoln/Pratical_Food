import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

List<String> filtroNome = [];
List<String> filtroID = [];
//qaolquer comentario ai

class Receita{
  String nome, id, modoDePreparo;
  List<Ingrediente> ingredientes;
}

class Ingrediente{
  String nome, id;
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    filtroID = [];
    return new Column(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Container(
              child: Padding(padding: EdgeInsets.only(top: 12),
                child: IconButton(
                  tooltip: 'Adicionar filtros',
                  icon: Icon(Icons.filter_alt, color: Colors.black), 
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context){
                      return new Card(
                        child: Padding(padding: EdgeInsets.only(left: 10, top: 20, bottom: 10),
                        child: Row(
                          children: <Widget>[
                            IconButton(icon: Icon(Icons.select_all), onPressed: () => filtraReceitas(filtroID)),
                            Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('ingredientes').snapshots(),
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
                                    child: Padding(padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(nomeIngrediente),
                                        ),
                                        Expanded(
                                          flex: 0, 
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: IconButton(tooltip: 'Adicionar filtro', icon: Icon(Icons.filter_alt),
                                            
                                              onPressed:(){
                                                setState(() {
                                                  filtroNome.add(nomeIngrediente);
                                                  filtroID.add(id);
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
                            ),
                          ],
                        )                   
                        )
                      ); 
                    }
                    )
                ),
              ),
            ),
          ),
          Expanded(child: GridView.builder(
            itemCount: filtroNome.length,           
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 7/2),
            itemBuilder: (BuildContext context, int index){
              return new GestureDetector(
                onTap: (){
                  setState(() {
                    filtroNome.removeAt(index);
                    filtroID.removeAt(index);
                  });                 
                },
                child: Card(
                  child: new GridTile(
                    child: Text(filtroNome[index], textAlign: TextAlign.center,)
                  ),
                )
              );  
            }
          )
          ),         
        ]
      );
  }
}

Future<List<Receita>> filtraReceitas(List<String> filtro) async{
  List<Receita> retornoAux = new List<Receita>();
  List<Receita> retorno = new List<Receita>();
  await FirebaseFirestore.instance.collection('receitas').get().then((value) async{ 
    value.docs.forEach((element) async{
      Receita receita = new Receita();
      receita.nome = element.data()['nome'];
      receita.id = element.data()['ID'];
      retornoAux.add(receita);
      
    });
  });
  for (int i = 0; i < retornoAux.length; i++){
    retornoAux[i].ingredientes = await getIngredientes(retornoAux[i].id);
  }
  
  retornoAux.forEach((element) {
    if (buscaFiltro(element, filtro)) retorno.add(element);
  });
  for (int i = 0; i < retorno.length; i++){
    
    print(retorno[i].nome);
    print(retorno[i].id);
    for (int j = 0; j < retorno[i].ingredientes.length; j++){
      print(retorno[i].ingredientes[j].nome);
      print(retorno[i].ingredientes[j].id);
      
    }
    print('\n');
  }
}

Future<List<Ingrediente>> getIngredientes(String idReceita) async{
  List<Ingrediente> retornoAux = new List<Ingrediente>();
  await FirebaseFirestore.instance.collection('receitas').doc(idReceita).collection('ingredientes').get().then((value) async{
    value.docs.forEach((element) {
      Ingrediente ingrediente = new Ingrediente();
      ingrediente.id = element.data()['ID'];
      ingrediente.nome = element.data()['nome'];
      retornoAux.add(ingrediente);

    });
  });
  return retornoAux;
}

bool buscaFiltro(Receita receita, List<String> filtro){
  int contador = 0;
  for (int i = 0; i < receita.ingredientes.length; i++){
    if (filtro.contains(receita.ingredientes[i].id)) contador++;
  }
  return filtro.length == contador;
}