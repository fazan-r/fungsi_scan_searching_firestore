import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aqs_final_project/bloc_register.dart';
import 'package:aqs_final_project/form_email_stf.dart';
import 'package:aqs_final_project/reusable_widget/alert_text.dart';
import 'package:aqs_final_project/services/auth.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key key, @required this.bloc}) : super(key: key);
  final RegisterBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<RegisterBloc>(
      create: (_) => RegisterBloc(auth: auth),
      dispose:  (_, bloc) => bloc.dispose(),
      child: Consumer<RegisterBloc>(
        builder: (_, bloc, __) => RegisterPage(bloc: bloc),
      ),
      
    );
  }

  void _showingSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR ABORTED BY USER') {
      return;
    }
    showingExceptionAlertDialog(
      context,
      title: 'Sign in failed',
      exception: exception,
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await bloc.signInAnonymously();
    } on Exception catch (e) {
      _showingSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await bloc.signInWithGoogle();
    } on Exception catch (e) {
      _showingSignInError(context, e);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await bloc.signInWithFacebook();
    } on Exception catch (e) {
      _showingSignInError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
          stream: bloc.isLoadingStream,
          initialData: false,
          builder: (context, snapshot) {
            return buildStack(context, snapshot.data);
          }),
    );
  }

  Widget buildStack(BuildContext context, bool isLoading) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[900], Colors.orangeAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Container(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.only(top: 70, left: 33),
          child: Text(
            'ABU',
            style: TextStyle(
                color: Colors.white, fontSize: 45, fontFamily: 'Marcellusfams'),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 120, left: 33),
          child: Text(
            'Quality Control',
            style: TextStyle(
                color: Colors.white, fontSize: 45, fontFamily: 'Marcellusfams'),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 172, left: 33),
          child: Text(
            'System',
            style: TextStyle(
                color: Colors.white, fontSize: 45, fontFamily: 'Marcellusfams'),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 250),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 33),
                  alignment: Alignment.topLeft,
                  height: 35,
                  child: Text(
                    'Welcome!',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 19,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                EmailSignInFormStf(),
                Container(
                  height: 50,
                  width: 50,
                ),
                _buildHeader(isLoading),
                Container(
                  height: 85,
                ),
                Text(
                  'or log in with',
                  style: TextStyle(color: Colors.white70),
                ),
                Container(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RawMaterialButton(
                      child: Image(
                        image: AssetImage('images/anonymous_logo3.png'),
                        width: 45,
                        height: 45,
                      ),
                      fillColor: Colors.blue[900],
                      onPressed:
                          isLoading ? null : () => _signInAnonymously(context),
                      elevation: 6,
                      shape: CircleBorder(),
                    ),
                    RawMaterialButton(
                      child: Image(
                        image: AssetImage('images/google_logo.png'),
                        width: 45,
                        height: 45,
                      ),
                      fillColor: Colors.blue[900],
                      onPressed:
                          isLoading ? null : () => _signInWithGoogle(context),
                      elevation: 6,
                      shape: CircleBorder(),
                    ),
                    RawMaterialButton(
                      child: Image(
                        image: AssetImage('images/fb_logo2.png'),
                        width: 45,
                        height: 45,
                      ),
                      fillColor: Colors.blue[900],
                      onPressed:
                          isLoading ? null : () => _signInWithFacebook(context),
                      elevation: 6,
                      shape: CircleBorder(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      height: 1,
    );
  }
}
