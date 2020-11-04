import 'package:flutter/material.dart';


class MenuDeslogar extends StatefulWidget {
  @override
  _MenuDeslogarState createState() => _MenuDeslogarState();
}

class _MenuDeslogarState extends State<MenuDeslogar> {
  @override
  Widget build(BuildContext context) {
   return showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Do you want to exit this application?'),
            content: Text('We hate to see you leave...'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  print("you choose no");
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  print("you choose yes");
                  //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
}