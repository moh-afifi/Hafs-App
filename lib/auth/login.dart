import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hafs/auth/bloc/bloc.dart';
import 'package:hafs/home_screens/screens/home_new.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

final bloc = Bloc();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool spinner = false, obscurePass = true;
  var _auth = FirebaseAuth.instance;


  @override
  void initState() {
    print('${bloc.emailController.hasValue}*************');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF1E3685),
        body: Builder(
          builder: (context) => ModalProgressHUD(
            inAsyncCall: spinner,
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Welcome to Hafs',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Please, Select which user you will be',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(child: SizedBox()),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Student',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF1E3685),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Teacher',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF1E3685),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    //margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xffF3F3F3),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        StreamBuilder<String>(
                          stream: bloc.email,
                          builder: (context, snapshot) => TextField(
                            onChanged: bloc.emailChanged,
                            decoration: InputDecoration(
                                errorText: snapshot.error,
                                filled: true,
                                labelText: 'email',
                                border: OutlineInputBorder(),
                                fillColor: Color(0xFFE6F7FF),
                                prefixIcon: Icon(Icons.mail),
                                hintText: 'Email address *',
                                hintStyle: TextStyle(color: Colors.blue)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        StreamBuilder<String>(
                          stream: bloc.password,
                          builder: (context, snapshot) => TextField(
                            onChanged: bloc.passwordChanged,
                            obscureText: obscurePass,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: obscurePass
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      obscurePass = !obscurePass;
                                    });
                                  },
                                ),
                                errorText: snapshot.error,
                                filled: true,
                                labelText: 'password',
                                border: OutlineInputBorder(),
                                fillColor: Color(0xFFE6F7FF),
                                hintText: 'Password *',
                                prefixIcon: Icon(Icons.lock_open),
                                hintStyle: TextStyle(color: Colors.blue)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        StreamBuilder<String>(
                            stream:bloc.checkTextEmail,
                            builder:( context, snapshot1){
                             return StreamBuilder<String>(
                                stream: bloc.checkTextPassword,
                                builder: (context,snapshot2){
                                   return InkWell(
                                    onTap:(snapshot1.hasData && snapshot2.hasData) ? () async {
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
                                          try {
                                            setState(() {
                                              spinner = true;
                                            });
                                            await _auth.signInWithEmailAndPassword(
                                                email: bloc.getEmail,
                                                password: bloc.getPassword);
                                            //-------------------------------------
                                            SharedPreferences prefs =
                                            await SharedPreferences.getInstance();
                                            prefs.setString('email', bloc.getEmail);
                                            //-------------------------------------
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => HomeNew(),
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

                                    } :null,
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: (snapshot1.hasData && snapshot2.hasData) ?Color(0xff004E6E):Colors.grey  ,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Forget Password',
                          style: TextStyle(
                            color: Color(0xFF1E3685),
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            'Or login with',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color(0xff192488),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Sign Up with Facebook',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color(0xffDD4B39),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Sign Up with Gmail',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have a teacher account? ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xFF1E3685),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
