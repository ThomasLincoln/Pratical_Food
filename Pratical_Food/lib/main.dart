
import 'package:Pratical_Food/authenticate/authenticate.dart';
import 'package:Pratical_Food/screens/LoginPage.dart';
import 'package:Pratical_Food/services/auth.dart';
import 'package:Pratical_Food/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Pratical_Food/screens/MenuPage.dart';
import 'package:Pratical_Food/screens/CadastroPage.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
   Widget build(BuildContext context) {
    return StreamProvider<User>.value(
    value: AuthService().user,
    child: MaterialApp(
    // Parça isso aqui ta completamente diferente mas ta começando no msm lugar, eu precisei fazer isso pra conseguir ir de pagina em pagina
    initialRoute: '/',
    routes: {
      // o '/' é pra dar nome pras paginas pra navegar certinho e pow pow
      '/': (context) => Wrapper(),
      '/second': (context) => CadastroPage(),
      '/third': (context) => MenuPage(),
    }));
  }

  //     
  //     
  //       home: LoginPage(),
  //     ),
  //   );
    
  // }
}
 //   return new MaterialApp(
 //     title: 'Practical Food',