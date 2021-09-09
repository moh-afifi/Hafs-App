import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hafs/profile/profile_settings.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditEmail extends StatefulWidget {
  EditEmail({this.name, this.gender, this.avatar,this.email});

  final String name,email;
  final int gender, avatar;

  @override
  _EditEmailState createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  //----------------------------------------
  var _fireStore = FirebaseFirestore.instance;
  var _auth = FirebaseAuth.instance;
  User user;
  // var loggedInUser;
  //
  // getCurrentUser() {
  //   user = _auth.currentUser;
  //   loggedInUser = user.email;
  //   print('$loggedInUser **************');
  // }

  bool spinner = false;
  String email, password;
  var _formKey = GlobalKey<FormState>();

  //----------------------------------------
  var emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    EmailValidator(errorText: 'email not valid'),
    PatternValidator(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
        errorText: 'email format not valid'),
  ]);

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
                      'Edit Email',
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
                      child: ListView(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter your new email:',
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
                              email = val;
                            },
                            validator: emailValidator,
                            decoration: InputDecoration(
                                filled: true,
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                                fillColor: Color(0xFFE6F7FF),
                                prefixIcon: Icon(Icons.person),
                                hintText: 'Email *',
                                hintStyle: TextStyle(color: Colors.blue)),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Confirm your old password:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xff004E6E),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            onChanged: (val) {
                              password = val;
                            },
                            validator: passwordValidator,
                            obscureText: true,
                            decoration: InputDecoration(
                                filled: true,
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                                fillColor: Color(0xFFE6F7FF),
                                prefixIcon: Icon(Icons.person),
                                hintText: 'Password *',
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
                                  //-------------------------------------------
                                  try {
                                    setState(() {
                                      spinner = true;
                                    });
                                    //-------------------------------------------
                                    await _auth.signInWithEmailAndPassword(
                                        email: widget.email,
                                        password: password);
                                    //--------------------------------------
                                    _auth.currentUser.updateEmail(email);
                                    //--------------------------------------
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('email', email);
                                    //--------------------------------------
                                    await _fireStore
                                        .collection('userDetails')
                                        .doc(widget.email)
                                        .delete();
                                    //-------------------------------------
                                    await _fireStore
                                        .collection('userDetails')
                                        .doc(email)
                                        .set({
                                      'name': widget.name,
                                      'email': email,
                                      'gender': widget.gender,
                                      'avatar': widget.avatar,
                                      'sort': DateTime.now()
                                          .millisecondsSinceEpoch
                                    });
                                    //--------------------------------------
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProfileSettings(),
                                      ),
                                    );
                                    setState(() {
                                      spinner = false;
                                    });
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
