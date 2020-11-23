
import 'package:Pratical_Food/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';
import 'authenticate/authenticate.dart';
import 'models/user.dart';
import 'screens/MenuPage.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    //retorna home ou retorna authenticateq
    if (user == null) {
      //print('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');
      return Authenticate();
    } else {
      //print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      return Material(
        child: MenuPage(),
      );
    }
  }
}
