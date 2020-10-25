import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Pages/home.dart';

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print('tudo certo carai, Email: $_email, Password: $_password');
    } else {
      print('tem algo errado ai carai');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          padding: EdgeInsets.all(16.0),
          child: new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  new TextFormField(
                    decoration: new InputDecoration(labelText: 'email'),
                    validator: (value) =>
                        value.isEmpty ? 'tem que digitar corno' : null,
                    onSaved: (value) => _email = value,
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "senha"),
                    validator: (value) =>
                        value.isEmpty ? 'tem que digitar corno' : null,
                    onSaved: (value) => _password = value,
                  ),
                  new RaisedButton(
                    child: new Text("login"),
                    onPressed: validateAndSave,
                  )
                ],
              ))),
    );
  }
}
