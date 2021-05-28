import 'package:aqs_final_project/reusable_widget/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

Future<void> showingExceptionAlertDialog(BuildContext context, {
  @required String title,
  @required Exception exception,
}) => 
    showingAlertDialog(
        context, 
        title: title, 
        content:_message(exception), 
        defaultActionText: 'OK',);

String _message(Exception exception){
    if (exception is FirebaseAuthException){
        return exception.message;
    }
    return exception.toString();
}