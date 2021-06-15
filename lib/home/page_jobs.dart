import 'package:aqs_final_project/reusable_widget/alert.dart';
import 'package:aqs_final_project/reusable_widget/alert_text.dart';
import 'package:aqs_final_project/services/auth.dart';
import 'package:aqs_final_project/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/jobs.dart';

class JobsPage extends StatelessWidget {
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

  Future<void> _createForm(BuildContext context) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.createForm(Job(name: 'blogging', ratePerHour: 123));
    } on FirebaseException catch (e) {
      showingExceptionAlertDialog(
          context,
          title: 'Operation Failed',
          exception: e)
      ;
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
          )),
        ),
        title: Text('Inbound Inspections'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: _buildContents(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createForm(context),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>> (
      stream: database.jobsStream(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          final jobs = snapshot.data;
          final children = jobs.map((job) => Text(job.name)).toList();
          return  ListView(children: children);
        }
        if (snapshot.hasError){
          return Center(child: Text('Some error occured'));
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}

