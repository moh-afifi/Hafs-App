import 'dart:async';
import 'validator.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validators implements BaseBloc {
  final nameController = BehaviorSubject<String>();
  final emailController = BehaviorSubject<String>();
  final passwordController = BehaviorSubject<String>();
  final confirmPasswordController = BehaviorSubject<String>();
  //----------------------------------------------------------------------------------------------
  Function(String) get nameChanged => nameController.sink.add;
  Function(String) get emailChanged => emailController.sink.add;
  Function(String) get passwordChanged => passwordController.sink.add;
  Function(String) get confirmPasswordChanged => confirmPasswordController.sink.add;
//----------------------------------------------------------------------------------------------
  // the transform is used to check whenever there is some changed in your textfield and done some validation
  //Another way
//   StreamSink<String> get emailChanged => _emailController.sink;
//   StreamSink<String> get passwordChanged => _passwordController.sink;

  //--------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------
  Stream<String> get name => nameController.stream.transform(nameValidator);
  Stream<String> get email => emailController.stream.transform(emailValidator);
  Stream<String> get password => passwordController.stream.transform(passwordValidator);
  Stream<String> get confirmPassword => confirmPasswordController.stream.transform(confirmPasswordValidator);
  //----------------------------------------------------------------------------------------------
  Stream<String> get checkTextName=> nameController.stream.transform(nameValidator);
  Stream<String> get checkTextEmail => emailController.stream.transform(emailValidator);
  Stream<String> get checkTextPassword => passwordController.stream.transform(passwordValidator);
  Stream<String> get checkTextConfirmPassword => confirmPasswordController.stream.transform(confirmPasswordValidator);
  //----------------------------------------------------------------------------------------------
  Stream<String> get checkPasswordMatch =>
      confirmPasswordController.stream.transform(passwordValidator)
          .doOnData((String c){
  // If the password is accepted (after validation of the rules)
  // we need to ensure both password and retyped password match
  if (0 != passwordController.value.compareTo(c)){
  // If they do not match, add an error
  confirmPasswordController.addError("password not matching");
  }});
  //----------------------------------------------------------------------------------------------
  String get getName => nameController.value;
  String get getEmail => emailController.value;
  String get getPassword => passwordController.value;
  String get getPasswordConfirm => confirmPasswordController.value;
  //----------------------------------------------------------------------------------------------

  @override
  void dispose() {
    emailController?.close();
    passwordController?.close();
    nameController?.close();
    confirmPasswordController?.close();
  }
}

  //----------------------------------------------------------------------------------------------
abstract class BaseBloc {
  void dispose();
}
