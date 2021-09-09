import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hafs/auth/bloc/bloc.dart';
import 'package:hafs/auth/login.dart';
import 'package:hafs/home_screens/screens/home_new.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

final bloc = Bloc();

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool male = false, female = false, obscurePass1 = true,obscurePass2 = true;
  int radio = 1;
  int selectedIndex;
  bool spinner = false;
  var _auth = FirebaseAuth.instance;
  var _fireStore = FirebaseFirestore.instance;

  //--------------------------------------------
  var imageFile;
  String downloadUrl;

  Future getImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(image.path);
      selectedIndex = null;
      print('$imageFile//////////////////////////////////');
    });
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(imageFile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    await uploadTask.whenComplete(() async {
      String downloadAddress = await firebaseStorageRef.getDownloadURL();
      downloadUrl = downloadAddress;
    });
  }
  //-------------------------------------------------------------------
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
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        StreamBuilder<String>(
                          stream: bloc.name,
                          builder: (context, snapshot) => TextField(
                            onChanged: bloc.nameChanged,
                            decoration: InputDecoration(
                                errorText: snapshot.error,
                                filled: true,
                                labelText: 'name',
                                border: OutlineInputBorder(),
                                fillColor: Color(0xFFE6F7FF),
                                prefixIcon: Icon(Icons.person),
                                hintText: 'Name *',
                                hintStyle: TextStyle(color: Colors.blue)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
                            obscureText: obscurePass1,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: obscurePass1
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      obscurePass1 = !obscurePass1;
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
                          stream: bloc.confirmPassword,
                          builder: (context, snapshot) => TextField(
                            onChanged: bloc.confirmPasswordChanged,
                            obscureText: obscurePass2,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: obscurePass2
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      obscurePass2 = !obscurePass2;
                                    });
                                  },
                                ),
                                errorText: snapshot.error,
                                filled: true,
                                labelText: 'confirm password',
                                border: OutlineInputBorder(),
                                fillColor: Color(0xFFE6F7FF),
                                hintText: 'confirm password *',
                                prefixIcon: Icon(Icons.lock_open),
                                hintStyle: TextStyle(color: Colors.blue)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Gender:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff004E6E),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 1,
                                groupValue: radio,
                                onChanged: (val) {
                                  setState(() {
                                    radio = val;
                                  });
                                }),
                            Text('male')
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 0,
                                groupValue: radio,
                                onChanged: (val) {
                                  setState(() {
                                    radio = val;
                                  });
                                }),
                            Text('female'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Avatar:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff004E6E),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  getImage();
                                },
                                child: CircleAvatar(
                                  child: Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Column(
                                      children: [
                                        Icon(Icons.upload_file),
                                        Text('Upload'),
                                      ],
                                    ),
                                  ),
                                  radius: 30,
                                  backgroundColor: Color(0xffBFE9FF),
                                ),
                              ),
                              myAvatar()[0],
                              myAvatar()[1],
                              myAvatar()[2],
                              myAvatar()[3],
                              myAvatar()[4],
                              myAvatar()[5],
                              myAvatar()[6],
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: bloc.checkTextName,
                            builder: (context, snapshot1) {
                              return StreamBuilder<String>(
                                stream: bloc.checkTextEmail,
                                builder: (context, snapshot2) {
                                  return StreamBuilder<String>(
                                      stream: bloc.checkTextPassword,
                                      builder: (context, snapshot3) {
                                        return StreamBuilder<String>(
                                            stream: bloc.checkTextConfirmPassword,
                                            builder: (context, snapshot4) {
                                            return  StreamBuilder<String>(
                                                stream: bloc.checkPasswordMatch,
                                                builder:(context,snapshot5){
                                                  return InkWell(
                                                    onTap:(snapshot1.hasData && snapshot2.hasData&& snapshot3.hasData&& snapshot4.hasData&& snapshot5.hasData) ?  () async {
                                                      var connectivityResult =
                                                      await (Connectivity()
                                                          .checkConnectivity());
                                                      if (connectivityResult !=
                                                          ConnectivityResult
                                                              .mobile &&
                                                          connectivityResult !=
                                                              ConnectivityResult
                                                                  .wifi) {
                                                        ScaffoldMessenger.of(
                                                            context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                'no internet connection'),
                                                            backgroundColor:
                                                            Colors.red,
                                                          ),
                                                        );
                                                      } else if (bloc.getPassword !=
                                                          bloc.getPasswordConfirm) {
                                                        ScaffoldMessenger.of(
                                                            context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                'password not matching'),
                                                            backgroundColor:
                                                            Colors.red,
                                                          ),
                                                        );
                                                      } else if (imageFile ==
                                                          null &&
                                                          selectedIndex == null) {
                                                        ScaffoldMessenger.of(
                                                            context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                'Please, select a profile photo'),
                                                            backgroundColor:
                                                            Colors.red,
                                                          ),
                                                        );
                                                      } else {
                                                        try {
                                                          setState(() {
                                                            spinner = true;
                                                          });

                                                          //-------------------------------------
                                                          if (imageFile != null)
                                                            await uploadPic(
                                                                context);
                                                          //-------------------------------------
                                                          await _auth
                                                              .createUserWithEmailAndPassword(
                                                              email: bloc.getEmail,
                                                              password:
                                                              bloc.getPassword);
                                                          //-------------------------------------
                                                          SharedPreferences
                                                          prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                          prefs.setString(
                                                              'email', bloc.getEmail);
                                                          //-------------------------------------
                                                          SharedPreferences
                                                          prefsName =
                                                          await SharedPreferences
                                                              .getInstance();
                                                          prefsName.setInt(
                                                              'gender', radio);
                                                          //-------------------------------------
                                                          await _fireStore
                                                              .collection(
                                                              'userDetails')
                                                              .doc(bloc.getEmail)
                                                              .set({
                                                            'name': bloc.getName,
                                                            'email': bloc.getEmail,
                                                            'gender': radio,
                                                            'avatar':
                                                            selectedIndex,
                                                            'imageUrl':
                                                            downloadUrl,
                                                            'sort': DateTime.now()
                                                                .millisecondsSinceEpoch
                                                          });
                                                          //-------------------------------------
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                  HomeNew(),
                                                            ),
                                                          );
                                                          //-------------------------------------
                                                          setState(() {
                                                            spinner = false;
                                                          });
                                                        } catch (e) {
                                                          setState(() {
                                                            spinner = false;
                                                          });
                                                          if (e
                                                          is FirebaseAuthException) {
                                                            if (e.code ==
                                                                'email-already-in-use') {
                                                              ScaffoldMessenger
                                                                  .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  backgroundColor:
                                                                  Colors.red,
                                                                  content: Text(
                                                                      'email already in use'),
                                                                ),
                                                              );
                                                            }
                                                          }
                                                        }
                                                      }

                                                    }:null,
                                                    child: Container(
                                                      padding: EdgeInsets.all(15),
                                                      decoration: BoxDecoration(
                                                        color:(snapshot1.hasData && snapshot2.hasData&& snapshot3.hasData&& snapshot4.hasData&& snapshot5.hasData) ? Color(0xff004E6E):Colors.grey,
                                                        borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(20),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Sign Up',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                            );
                                            });
                                      });
                                },
                              );
                            }),
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
                          height: 10,
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
                              'Already have an account? ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xFF1E3685),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
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

  List<Widget> myAvatar() {
    return [
      InkWell(
        onTap: () {
          setState(() {
            selectedIndex = 1;
            imageFile = null;
          });
        },
        child: CircleAvatar(
          child: Image.asset('images/avatar1.jpg'),
          radius: selectedIndex == 1 ? 60 : 30,
          backgroundColor: Colors.transparent,
        ),
      ),
      InkWell(
        onTap: () {
          setState(() {
            selectedIndex = 2;
            imageFile = null;
          });
        },
        child: CircleAvatar(
          child: Image.asset('images/avatar2.jpg'),
          radius: selectedIndex == 2 ? 60 : 30,
          backgroundColor: Colors.transparent,
        ),
      ),
      InkWell(
        onTap: () {
          setState(() {
            selectedIndex = 3;
            imageFile = null;
          });
        },
        child: CircleAvatar(
          child: Image.asset('images/avatar3.jpg'),
          radius: selectedIndex == 3 ? 60 : 30,
          backgroundColor: Colors.transparent,
        ),
      ),
      InkWell(
        onTap: () {
          setState(() {
            selectedIndex = 4;
            imageFile = null;
          });
        },
        child: CircleAvatar(
          child: Image.asset('images/avatar4.jpg'),
          radius: selectedIndex == 4 ? 60 : 30,
          backgroundColor: Colors.transparent,
        ),
      ),
      InkWell(
        onTap: () {
          setState(() {
            selectedIndex = 5;
            imageFile = null;
          });
        },
        child: CircleAvatar(
          child: Image.asset('images/avatar5.jpg'),
          radius: selectedIndex == 5 ? 60 : 30,
          backgroundColor: Colors.transparent,
        ),
      ),
      InkWell(
        onTap: () {
          setState(() {
            selectedIndex = 6;
            imageFile = null;
          });
        },
        child: CircleAvatar(
          child: Image.asset('images/avatar6.jpg'),
          radius: selectedIndex == 6 ? 60 : 30,
          backgroundColor: Colors.transparent,
        ),
      ),
      InkWell(
        onTap: () {
          setState(() {
            selectedIndex = 7;
            imageFile = null;
          });
        },
        child: CircleAvatar(
          child: Image.asset('images/avatar7.jpg'),
          radius: selectedIndex == 7 ? 60 : 30,
          backgroundColor: Colors.transparent,
        ),
      ),
    ];
  }
}
