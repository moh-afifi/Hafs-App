// final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
// User currentUser = firebaseAuth.currentUser;
// currentUser.updatePassword("newpassword").then((){
// // Password has been updated.
// }).catchError((err){
// // An error has occured.
// })

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool spinner = false;
  String password;

  var _formKey = GlobalKey<FormState>();

  var passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password at least 8 chars'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'password must have special char'),
  ]);
  //----------------------------------------
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff1E3685),
              Color(0xffAB3FCF),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ModalProgressHUD(
            inAsyncCall: spinner,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                 'Edit Password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xff004E6E),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: passwordValidator,
                            onChanged: (val) {
                              password = val;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              labelText: 'password',
                              border: OutlineInputBorder(),
                              fillColor: Color(0xFFE6F7FF),
                              prefixIcon: Icon(Icons.lock_open),
                              hintText: 'Password *',
                              hintStyle: TextStyle(color: Colors.blue),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          InkWell(
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                var connectivityResult =
                                await (Connectivity().checkConnectivity());
                                if (connectivityResult !=
                                    ConnectivityResult.mobile &&
                                    connectivityResult !=
                                        ConnectivityResult.wifi) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('no internet connection'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    spinner = true;
                                  });
                                  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                                  User currentUser = firebaseAuth.currentUser;
                                  currentUser.updatePassword(password).then((val){
                                    // Password has been updated.
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Password has been updated'),
                                        backgroundColor: Colors.teal,
                                      ),
                                    );
                                  }).catchError((err){
                                    // An error has occured.
                                  });
                                  setState(() {
                                    spinner = false;
                                  });
                                }
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Color(0xff004E6E),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


