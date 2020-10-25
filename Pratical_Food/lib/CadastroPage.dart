import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {

  //Senha no começo vai ta oculta pew pew
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  } //função que faz o texto ficar oculto ou não

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 80,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset("assets/ednaldo.png"),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              autofocus: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "DIgite seu email",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  )),
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              autofocus: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "Digite seu email novamente",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  )),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              autofocus: false,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  labelText: "Digite sua senha",
                  labelStyle: TextStyle(
                    letterSpacing: 1.0,
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  )),
              style: TextStyle(fontSize: 20),
              obscureText: _obscureText,             
            ),
            TextFormField(
              autofocus: false,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  labelText: "Digite sua senha novamente",
                  labelStyle: TextStyle(
                    letterSpacing: 1.0,
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  )),
              style: TextStyle(fontSize: 20),
              obscureText: _obscureText,             
            ),
            new FlatButton(
              onPressed: _toggle, 
              child: new Text(_obscureText ? "Mostrar" : "Ocultar")), //botaozada de mostrar/ocultar senha

            new RaisedButton(
              child: Text ('Cadastrar'),
              color: Colors.yellow,
              onPressed: (){
                Navigator.pushNamed(context, '/third');
              }
           ), //botao login
          ],
        ),
      ),
    );
  }
}

// flutter run -t lib/pages/main.dart
