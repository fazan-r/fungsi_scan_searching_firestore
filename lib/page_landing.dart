
import 'package:aqs_final_project/home/jobs/page_jobs.dart';
import 'package:aqs_final_project/home/personal_information.dart';
import 'package:aqs_final_project/page_register.dart';
import 'package:aqs_final_project/services/auth.dart';
import 'package:aqs_final_project/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.active){
            final User user = snapshot.data;
            if (user == null){
              return RegisterPage.create(context);
            }
            return Provider<Database>(
              create: (_) => FirestoreDatabase(uid: user.uid),
              child: PersonalInformation(),);
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
