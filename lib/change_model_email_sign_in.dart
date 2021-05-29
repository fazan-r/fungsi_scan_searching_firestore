import 'package:aqs_final_project/model_email_sign_in.dart';
import 'package:aqs_final_project/services/auth.dart';
import 'package:aqs_final_project/validators.dart';
import 'package:flutter/foundation.dart';


class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailSignInChangeModel({
    @required this.auth,
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });
  final AuthBase auth;
  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(email, password);
      } else {
        await auth.createUserWithEmailAndPassword(email, password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  String get primaryButtonText{
    return formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
  }

  String get secondaryButtonText{
    return formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
  }

  bool get canSubmit{
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        isLoading;
  }

  String get passwordErrorText{
    bool showErrorText =
        submitted && passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailErrorText{
    bool showErrorText =
        submitted && emailValidator.isValid(email);
    return showErrorText? invalidEmailErrorText : null;
  }

  void toggleFormType(){
    updateWith(
      email: '',
      password: '',
      formType: this.formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.Register
          : EmailSignInFormType.signIn,
      isLoading: false,
      submitted: false,
    );
  }
  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);

  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
      this.email = email ?? this.email;
      this.password = password ?? this.password;
      this.formType = formType ?? this.formType;
      this.isLoading = isLoading ?? this.isLoading;
      this.submitted = submitted ?? this.submitted;
      notifyListeners();
  }
}
