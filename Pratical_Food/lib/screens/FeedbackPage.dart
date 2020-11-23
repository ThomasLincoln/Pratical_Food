import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    String feedback;
    if(feedback == '') feedback = null;
    final guardarFeedbackController = new TextEditingController();
    if (feedback != null){
      guardarFeedbackController.text = feedback;
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            decoration: InputDecoration(             
              hintText: 'Nos dê sua opinião!',
              
            ),
            controller: guardarFeedbackController,
            onFieldSubmitted: (String filtr){
              setState(() {
                 feedback = guardarFeedbackController.text;                
              });             
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Image.asset('assets/feedback.png'),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text('Agradecemos a contribuição', style: TextStyle(fontSize: 20)),
        )
      ]
      
    );
  }
}