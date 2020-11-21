import 'package:Pratical_Food/authenticate/register.dart';
import 'package:Pratical_Food/screens/CadastroPage.dart';
import 'package:Pratical_Food/screens/LoginPage.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Container(
        child: LoginPage(toggleView: toggleView),
      );
    } else {
      return Container(
        child: CadastroPage(toggleView: toggleView),
      );
    }
  }
}
