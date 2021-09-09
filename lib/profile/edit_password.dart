import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hafs/profile/widgets/change_password_dialog.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EditPassword extends StatefulWidget {
  EditPassword({this.email});
  final String email;
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  bool spinner = false;
  String oldPassword ,newPassword;
  var _formKey = GlobalKey<FormState>();
  var _auth = FirebaseAuth.instance;
  //----------------------------------------
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
                Row(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    SizedBox(width: 10,),
                    Text(
                      'Edit Password',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
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
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter Old Password:',
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
                            onChanged: (val) {
                              oldPassword = val;
                            },
                            validator: passwordValidator,
                            obscureText: true,
                            decoration: InputDecoration(
                                filled: true,
                                labelText: 'New Password',
                                border: OutlineInputBorder(),
                                fillColor: Color(0xFFE6F7FF),
                                prefixIcon: Icon(Icons.person),
                                hintText: 'New Password *',
                                hintStyle: TextStyle(color: Colors.blue)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Enter New Password:',
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
                            onChanged: (val) {
                              newPassword = val;
                            },
                            validator: passwordValidator,
                            obscureText: true,
                            decoration: InputDecoration(
                                filled: true,
                                labelText: 'New Password',
                                border: OutlineInputBorder(),
                                fillColor: Color(0xFFE6F7FF),
                                prefixIcon: Icon(Icons.person),
                                hintText: 'New Password *',
                                hintStyle: TextStyle(color: Colors.blue)),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          InkWell(
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                var connectivityResult = await (Connectivity()
                                    .checkConnectivity());
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

                                  try {
                                    setState(() {
                                      spinner = true;
                                    });
                                    var user =
                                        FirebaseAuth.instance.currentUser;
                                    await _auth.signInWithEmailAndPassword(
                                        email: widget.email,
                                        password: oldPassword);

                                   await user.updatePassword(newPassword).then((_) {

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.teal,
                                          content: Text(
                                            'Password changed successfully',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).catchError((error) {
                                     ScaffoldMessenger.of(context)
                                         .showSnackBar(
                                       SnackBar(
                                         backgroundColor: Colors.red,
                                         content: Text(
                                           "Password can't be changed",
                                           style: TextStyle(
                                             fontSize: 15,
                                           ),
                                         ),
                                       ),
                                     );
                                    });
                                    setState(() {
                                      spinner = false;
                                    });
                                    Navigator.pop(context);
                                  } catch (e) {
                                    setState(() {
                                      spinner = false;
                                    });
                                    if (e is FirebaseAuthException) {
                                      if (e.code == 'user-not-found') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.black,
                                            content: Text('email not found'),
                                          ),
                                        );
                                      } else if (e.code == 'wrong-password') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.black,
                                            content: Text('wrong password'),
                                          ),
                                        );
                                      }
                                    }
                                  }
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
