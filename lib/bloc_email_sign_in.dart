import 'dart:async';

import 'package:aqs_final_project/model_email_sign_in.dart';
import 'package:aqs_final_project/services/auth.dart';
import 'package:flutter/foundation.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth});
  final AuthBase auth;

  final StreamController<EmailSignInModel> _modelController =
  StreamController<EmailSignInModel>();

  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
  }

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(_model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void toggleFormType(){
    updateWith(
      email: '',
      password: '',
      formType: _model.formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.Register
          : EmailSignInFormType.signIn,
      isLoading: false,
      submitted: false,
    );
  }
  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);

  void updateWith({ String email,
  String password,
  EmailSignInFormType formType,
  bool isLoading,
  bool submitted,
  }) {
    //update mdoel
    _model = _model.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted,
    );
    // add update model to _modelController
    _modelController.add(_model);
  }
}
