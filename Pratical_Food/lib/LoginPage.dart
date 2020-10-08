import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
                  labelText: "seu email de ednaldo gang",
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
                  labelText: "senha ednaldo gang",
                  labelStyle: TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  )),
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
// flutter run -t lib/pages/main.dart
