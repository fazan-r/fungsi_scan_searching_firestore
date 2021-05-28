import 'package:aqs_final_project/model_email_sign_in.dart';
import 'package:aqs_final_project/reusable_widget/alert_text.dart';
import 'package:aqs_final_project/services/auth.dart';
import 'package:aqs_final_project/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EmailSignInFormStf extends StatefulWidget with EmailAndPasswordValidators {
  @override
  _EmailSignInFormStfState createState() => _EmailSignInFormStfState();
}

class _EmailSignInFormStfState extends State<EmailSignInFormStf> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  bool _submitted = false;
  bool _isLoading = false;

  @override
  void dispose(){
    print('dispose called');
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      showingExceptionAlertDialog(
        context,
        title: 'Sign In Failed',
        exception: e,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.Register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
    final secondarytext = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35),
      child: Column(
        children: <Widget>[
          _buildEmailTextField(),
          Container(
            height: 10,
          ),
          _buildPasswordTextField(),
          Container(
            height: 30,
          ),
          Container(
            height: 40,
            width: 275,
            child: RaisedButton(
              shape: StadiumBorder(),
              elevation: 6,
              onPressed: submitEnabled ? _submit : null,
              color: Colors.blue[900],
              child: Text(
                primaryText,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          FlatButton(
            onPressed: !_isLoading ? _toggleFormType : null,
            child: Text(secondarytext),
          ),
        ],
      ),
    );
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: 'Password',
        enabled: _isLoading == false,
      ),
      obscureText: true,
      onEditingComplete: _submit,
      onChanged: (password) => _updateState(),
      textInputAction: TextInputAction.done,
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: 'abc@gmail.com',
        enabled: _isLoading == false,
      ),
      onEditingComplete: _emailEditingComplete,
      onChanged: (email) => _updateState(),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );
  }

  void _updateState() {
    setState(() {});
  }
}
