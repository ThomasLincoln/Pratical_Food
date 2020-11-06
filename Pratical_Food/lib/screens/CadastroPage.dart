import 'package:Pratical_Food/services/auth.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  final Function toggleView;
  CadastroPage({this.toggleView});

  //Senha no começo vai ta oculta pew pew
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String email = '';
  String email2 = '';
  String password = '';
  String password2 = '';
  String error = '';

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
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset("assets/ednaldo.png"),
            ),
            SizedBox(
              height: 20,
            ),
            //email1
            TextFormField(
              validator: (val) => val.isEmpty ? 'Email está incorreto' : null,
              onChanged: (val) {
                setState(() => email = val);
              },
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

              //email2
            ),
            TextFormField(
              validator: (val) => val.isEmpty ? 'Email está incorreto' : null,
              onChanged: (val) {
                setState(() => email2 = val);
              },
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

            //¹senha¹
            TextFormField(
              validator: (val) => val.length < 6
                  ? 'A senha deve contar no minimo 6 caracteres'
                  : null,
              onChanged: (val) {
                setState(() => password = val);
              },
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

            //senha²
            TextFormField(
              validator: (val) => val.length < 6
                  ? 'A senha deve contar no minimo 6 caracteres'
                  : null,
              onChanged: (val) {
                setState(() => password2 = val);
              },
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

            //botões
            //botaozada de mostrar/ocultar senha
            new FlatButton(
                onPressed: _toggle,
                child: new Text(_obscureText ? "Mostrar" : "Ocultar")),
            //botao cadastro
            new RaisedButton(
              child: Text('Cadastrar'),
              color: Colors.yellow,
              onPressed: () async {
                if (_formKey.currentState.validate() &&
                    email == email2 &&
                    password == password2) {
                  dynamic result =
                      await _auth.registerWithEmailAndPassword(email, password);
                  if (result == null) {
                    setState(() => error = 'Algo não está correto');
                  }
                }
              },
            ),
            //botao Logar
            new RaisedButton(
              child: Text('Já tem uma conta?'),
              color: Colors.yellow,
              onPressed: () {
                widget.toggleView();
              },
            ),
            SizedBox(height: 12.0),
            Text(error),
          ],
        ),
      ),
    ));
  }
}

// flutter run -t lib/pages/main.dart
