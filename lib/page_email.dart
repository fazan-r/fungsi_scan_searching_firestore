
import 'package:flutter/material.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 8,
          backgroundColor: Colors.amber,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[900], Colors.orangeAccent],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                )
            ),
          ),
          title: Text('ABU Quality Control System'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      body: Container(),
      ),
    );
  }
}
