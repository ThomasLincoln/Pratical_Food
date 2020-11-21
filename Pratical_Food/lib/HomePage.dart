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
  String nome, id, modoDePreparo, endereco;
  List<Ingrediente> ingredientes;
}

class Ingrediente{
  String nome, id, quantidade, unidade;
}

class _HomePageState extends State<HomePage> {
  @override
  String filtroPesquisa;
  Widget build(BuildContext context) {
    if(filtroPesquisa == '') filtroPesquisa = null;
    final guardarController = new TextEditingController();
    if (filtroPesquisa != null){
      guardarController.text = filtroPesquisa;
    }
    return new Column(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Container(
              child: Padding(padding: EdgeInsets.only(top: 10),
                child: IconButton(
                  tooltip: 'Adicionar filtros',
                  icon: Icon(Icons.filter_alt, color: Colors.black), 
                  onPressed: () async=> await showDialog(
                    context: context,
                    builder: (context){
                      
                      return new StatefulBuilder(
                        builder: (context, setState){
                          return Padding(
                            padding: EdgeInsets.all(22),
                            child: Card(                             
                              child: Column(
                                children: <Widget>[   
                                  Padding(
                                    padding: EdgeInsets.only(top: 13)
                                  ),  
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: '   Digite o nome de um ingrediente',
                                      ),
                                      controller: guardarController,
                                      onFieldSubmitted: (String filtr){
                                        setState(() {
                                          filtroPesquisa = guardarController.text;                
                                        });             
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: filtroPesquisa != null ? FirebaseFirestore.instance.collection('ingredientes').where('nome', isGreaterThanOrEqualTo: filtroPesquisa).where('nome', isLessThan: filtroPesquisa + 'z').snapshots(): FirebaseFirestore.instance.collection('ingredientes').snapshots(),
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
                      );
                    }
                  ).then((value) => setState((){}))
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
          Expanded(
            flex: 5,
            child: FutureBuilder(
            future: filtraReceitas(filtroID),
            builder: (BuildContext context, AsyncSnapshot<List<Receita>> snapshot){
              if (!snapshot.hasData) return const Text('Carregando...');
              else {
                List<Receita> listaReceitas = snapshot.data;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: listaReceitas.length,
                  itemBuilder: (_, int index) {
                    return new Card(
                      child: new GestureDetector(
                        child: new GridTile(
                          child: Column(
                            children: [
                              Expanded(
                                child: new Image.asset(listaReceitas[index].endereco, fit: BoxFit.cover),
                                ),
                              Padding(
                                padding: EdgeInsets.only(top: 6, bottom: 6),
                                child: Text(listaReceitas[index].nome, textAlign: TextAlign.center),
                              ),                      
                            ],
                          )
                        ),
                        onTap: ()async {await showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10, top: 30),
                              child: Dialog(
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      new Container(
                                        padding: const EdgeInsets.only(top: 30), //parte de cima da imagem
                                        child: new Image.asset(listaReceitas[index].endereco, height: 150, width: 220),
                                      ),
                                      new Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: IconButton(
                                          icon: Icon(Icons.favorite),
                                          tooltip: 'Adicionar aos favoritos',
                                          onPressed: (){
                                            FirebaseFirestore.instance.collection('usuarios').doc('Jose').collection('favoritos').doc(listaReceitas[index].id).set({
                                              'nome':listaReceitas[index].nome,
                                              'ID':listaReceitas[index].id
                                            });
                                          },
                                        ),
                                      ),
                                      new Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Text(listaReceitas[index].nome, textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),// Tamanho do texto
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                        child: new Text(listaReceitas[index].modoDePreparo, style: TextStyle(fontSize: 15), textAlign: TextAlign.justify),
                                      ),
                                      Container(
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: listaReceitas[index].ingredientes.length,
                                          itemBuilder: (_, int index1){
                                            return Padding(
                                              padding: EdgeInsets.only(left: 20, right: 20),
                                              child: new Text(listaReceitas[index].ingredientes[index1].nome + ": " + listaReceitas[index].ingredientes[index1].quantidade + " " + listaReceitas[index].ingredientes[index1].unidade)
                                            );
                                          }
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                              ),
                            );
                          }
                        );
                        },
                      )
                    );
                    //GridTile(child: Text(listaReceitas[index].nome));
                  }
                );
              }
            },
          )
          )     
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
      receita.modoDePreparo = element.data()['modoDePreparo'];
      receita.endereco = element.data()['endereço'];
      retornoAux.add(receita);
      
    });
  });
  for (int i = 0; i < retornoAux.length; i++){
    retornoAux[i].ingredientes = await getIngredientes(retornoAux[i].id);
  }
  
  retornoAux.forEach((element) {
    if (buscaFiltro(element, filtro)) retorno.add(element);
  });
  return retorno;
}

Future<List<Ingrediente>> getIngredientes(String idReceita) async{
  List<Ingrediente> retornoAux = new List<Ingrediente>();
  await FirebaseFirestore.instance.collection('receitas').doc(idReceita).collection('ingredientes').get().then((value) async{
    value.docs.forEach((element) {
      Ingrediente ingrediente = new Ingrediente();
      ingrediente.id = element.data()['ID'];
      ingrediente.nome = element.data()['nome'];
      ingrediente.quantidade = element.data()['quantidade'];
      ingrediente.unidade = element.data()['unidade'];
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