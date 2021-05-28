import 'package:aqs_final_project/page_landing.dart';
import 'package:aqs_final_project/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        theme: ThemeData(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(fontFamily: 'Marcellusfams', fontSize: 20, color: Colors.white),
          ),
        ),
        home: LandingPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
