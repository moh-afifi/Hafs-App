import 'dart:async';

mixin Validators {
  var nameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if (name.isEmpty) {
        sink.addError("Name is empty");
      } else {
        sink.add(name);
      }
    },
  );

  var emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.isEmpty) {
        sink.addError("Email is empty");
      } else if (!(RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'))
          .hasMatch(email)) {
        sink.addError("Email format not valid");
      } else {
        sink.add(email);
      }
    },
  );

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.isEmpty) {
        sink.addError("Password is empty");
      } else if (password.length < 7) {
        sink.addError("Password length can\'t be less than 8 chars.");
      } else if (!(RegExp(r'(?=.*?[#?!@$%^&*-])').hasMatch(password))) {
        sink.addError("Password must have special charcater.");
      } else {
        sink.add(password);
      }
    },
  );

  var confirmPasswordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (confirmPassword, sink) {
      if (confirmPassword.isEmpty) {
        sink.addError("Password is empty");
      } else if (confirmPassword.length < 7) {
        sink.addError("Password length can\'t be less than 8 chars.");
      } else if (!(RegExp(r'(?=.*?[#?!@$%^&*-])').hasMatch(confirmPassword))) {
        sink.addError("Password must have special charcater.");
      } else {
        sink.add(confirmPassword);
      }
    },
  );
}
