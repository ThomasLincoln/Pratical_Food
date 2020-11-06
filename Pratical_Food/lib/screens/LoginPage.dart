import 'package:flutter/material.dart';
import 'package:Pratical_Food/services/auth.dart';

class LoginPage extends StatefulWidget {
  //isso aqui é para a função de mudar a tela funcionar
  final Function toggleView;
  LoginPage({this.toggleView});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //instanciando o auth
  final AuthService _auth = AuthService();
  //instanciando o formulario
  final _formKey = GlobalKey<FormState>();
  //variavel da função q deixa o testo oculto ou nao
  bool _obscureText = true;
  String email = '';
  String password = '';
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
        top: 150,
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
              child: Image.asset("assets/ednaldo.jpg"),
            ),
            SizedBox(
              height: 20,
            ),

            //espaço do email
            TextFormField(
              validator: (val) => val.isEmpty ? 'O email está incorreta' : null,
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
            ),
            SizedBox(
              height: 20,
            ),

            // espaço da senha
            TextFormField(
              validator: (val) => val.length < 6 ? 'digita algo maior' : null,
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

            //botaozada de mostrar/ocultar senha
            new FlatButton(
                onPressed: _toggle,
                child: new Text(_obscureText ? "Mostrar" : "Ocultar")),
            //botao login
            new RaisedButton(
                child: Text('Logar'),
                color: Colors.yellow,
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result =
                        await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() => error = 'arruma ai o bagulho');
                    }
                  }
                }),
            //botao cadastro
            new RaisedButton(
              child: Text('Cadastrar'),
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
