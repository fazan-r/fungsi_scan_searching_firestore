
import 'package:aqs_final_project/change_model_email_sign_in.dart';
import 'package:aqs_final_project/reusable_widget/alert_text.dart';
import 'package:aqs_final_project/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailSignInFormChangeNotifier extends StatefulWidget {
  EmailSignInFormChangeNotifier ({@required this.model});
  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (_) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (_, model, __) => EmailSignInFormChangeNotifier(model: model),
      ),
    );
  }


  @override
  _EmailSignInFormChangeNotifierState createState() => _EmailSignInFormChangeNotifierState();
}

class _EmailSignInFormChangeNotifierState extends State<EmailSignInFormChangeNotifier> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  EmailSignInChangeModel get model => model;

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
    try {
      await model.submit();
    } on FirebaseAuthException catch (e) {
      print(e);
      showingExceptionAlertDialog(
        context,
        title: 'Sign In Failed',
        exception: e,
      );
    }
  }

  void _emailEditingComplete() {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
     model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(){

    return[
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
          onPressed: model.canSubmit ? _submit : null,
          color: Colors.blue[900],
          child: Text(
            model.primaryButtonText,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
      FlatButton(
        onPressed: !model.isLoading ? _toggleFormType : null,
        child: Text(model.secondaryButtonText),
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        errorText: model.passwordErrorText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: 'Password',
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      onEditingComplete: _submit,
      onChanged: model.updatePassword,
      textInputAction: TextInputAction.done,
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        errorText: model.emailErrorText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: 'abc@gmail.com',
        enabled: model.isLoading == false,
      ),
      onEditingComplete: () => _emailEditingComplete(),
      onChanged: model.updateEmail,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );
  }

  @override
  Widget build(BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 35, right: 35),
          child: Column(
            children: _buildChildren(),
          ),
        );
  }
}
