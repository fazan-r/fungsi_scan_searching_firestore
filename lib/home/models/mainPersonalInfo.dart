
import 'package:aqs_final_project/reusable_widget/alert.dart';
import 'package:aqs_final_project/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPersonalInformation extends StatefulWidget {
  @override
  _MainPersonalInformationState createState() => _MainPersonalInformationState();
}

class _MainPersonalInformationState extends State<MainPersonalInformation> {

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showingAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure want to log out?',
      cancelActiontext: 'Cancel',
      defaultActionText: 'Logout',
    );

    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Text('Profile'),
          actions: <Widget>[
            FlatButton(
              onPressed: () => _confirmSignOut(context),
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 560,
            child: ListView(
              children: <Widget>[
                Container(
                  height: 280,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 272,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 6,
                        onPressed: (){

                        },
                        color: Colors.blue[900],
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
