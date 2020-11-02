import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  //Senha no começo vai ta oculta pew pew
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          top: 150,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset("assets/ednaldo.jpg"),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              autofocus: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "Digite seu email",
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
            new FlatButton(
              onPressed: _toggle, 
              child: new Text(_obscureText ? "Mostrar" : "Ocultar")), //botaozada de mostrar/ocultar senha

            new RaisedButton(
              child: Text ('Logar'),
              color: Colors.yellow,
              onPressed: (){
                Navigator.pushNamed(context, '/third');
              }
           ), //botao login
            new RaisedButton(
              child: Text ('Cadastrar'),
              color: Colors.yellow,
              onPressed: (){
                Navigator.pushNamed(context, '/second');
              }
           ) //botao cadastro
          ],
        ),
      ),
    );
  }
}

// flutter run -t lib/pages/main.dart
