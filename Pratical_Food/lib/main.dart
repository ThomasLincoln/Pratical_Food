import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'title',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  //Senha no começo vai ta oculta pew pew
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    try {
      final form = formKey.currentState;
      if (validateAndSave()) {
        form.save();
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: _email, password: _password))
            .user;
        print('logou ai: ' + user.uid);
      }
    } catch (e) {
      print('Error $e');
    }
  }

  void moveToRegister() {
    setState(() {
      _formType = FormType.register;
    });
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
                  new RaisedButton(
                    child: new Text("login"),
                    onPressed: validateAndSubmit,
                  ),
                  new RaisedButton(
                    child: new Text('criar uma conta '),
                    onPressed: moveToRegister,
                  ),
                ],
              ))),
    );
  }

  List<Widget> buildInputs() {
    return {
      new TextFormField(
        decoration: new InputDecoration(labelText: 'email'),
        validator: (value) => value.isEmpty ? 'tem que digitar corno' : null,
        onSaved: (value) => _email = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: "senha"),
        validator: (value) => value.isEmpty ? 'tem que digitar corno' : null,
        onSaved: (value) => _password = value,
      ),
    };
  }
}
