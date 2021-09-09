import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hafs/profile/edit_email.dart';
import 'package:hafs/profile/edit_name.dart';
import 'package:hafs/profile/edit_password.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSettings extends StatefulWidget {
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  bool notification1 = false, notification2 = false, spinner = false;
  String name, email;
  int male, female, gender, avatar;
  int selectedIndex;
  var _fireStore = FirebaseFirestore.instance;
  var loggedInUser;

  //--------------------------------------------
  var imageFile;
  String downloadUrl;

  Future getImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(image.path);
      selectedIndex=null;
      print('$imageFile//////////////////////////////////');
    });
  }
  Future uploadPic(BuildContext context) async {
    String fileName = basename(imageFile.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    await uploadTask.whenComplete(() async{
      String downloadAddress = await firebaseStorageRef.getDownloadURL();
      downloadUrl = downloadAddress;
    });

  }
  //--------------------------------------------
  getGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    gender = prefs.getInt('gender');
    print('$gender****************');
    if (gender == 1) {
      male = gender;
      female = 0;
    } else if (gender == 0) {
      male = 1;
      female = gender;
    }
  }
  //-----------------------------------------
  getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedInUser = prefs.getString('email');
  }

  //-----------------------------------------
  @override
  void initState() {
    setState(() {
      getGender();
      getCurrentUser();
    });
    super.initState();
  }

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
              // mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 25,
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
                    Text(
                      'Account Settings',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _fireStore.collection('userDetails').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var snap = snapshot.data.docs;
                      for (var item in snap) {
                        if (loggedInUser == item.get('email')) {
                          name = item.get('name');
                          email = item.get('email');
                          avatar = item.get('avatar');
                        }
                      }
                      return Container(
                        //margin: EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: ListView(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Avatar:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff8D8D8D),
                                      fontWeight: FontWeight.bold,
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
                                  Text(
                                    'Account Settings:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff8D8D8D),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Card(
                                    color: Color(0xFFE6F7FF),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Name: $name',
                                            style: TextStyle(
                                              color: Color(0xff004E6E),
                                              fontSize: 16,
                                            ),
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.teal,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditName(
                                                      email: loggedInUser,
                                                    ),
                                                  ),
                                                );
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Card(
                                    color: Color(0xFFE6F7FF),
                                    child: Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Email: $email',
                                            style: TextStyle(
                                              color: Color(0xff004E6E),
                                              fontSize: 16,
                                            ),
                                          ),
                                          // IconButton(
                                          //     icon: Icon(
                                          //       Icons.edit,
                                          //       color: Colors.teal,
                                          //       size: 30,
                                          //     ),
                                          //     onPressed: () {
                                          //       // Navigator.push(
                                          //       //   context,
                                          //       //   MaterialPageRoute(
                                          //       //     builder: (context) =>
                                          //       //         EditEmail(
                                          //       //       name: name,
                                          //       //       avatar: avatar,
                                          //       //       gender: gender,
                                          //       //     ),
                                          //       //   ),
                                          //       // );
                                          //     })
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditPassword(email: email,),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Change Password',
                                      style: TextStyle(
                                        color: Color(0xff004E6E),
                                        fontSize: 15,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Gender:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff8D8D8D),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                          value: male,
                                          groupValue: gender,
                                          onChanged: (val) {
                                            setState(() {
                                              gender = val;
                                            });
                                          }),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'male',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xff4385A7),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                          value: female,
                                          groupValue: gender,
                                          onChanged: (val) {
                                            setState(() {
                                              gender = val;
                                            });
                                          }),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'female',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff4385A7),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Send me notification with \nthe next classroom',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Switch(
                                          value: notification1,
                                          activeColor: Color(0xff32D74B),
                                          onChanged: (val) {
                                            setState(() {
                                              notification1 = !notification1;
                                            });
                                          })
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Send me notifications for homework',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Switch(
                                          value: notification2,
                                          activeColor: Color(0xff32D74B),
                                          onChanged: (val) {
                                            setState(() {
                                              notification2 = !notification2;
                                            });
                                          })
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  spinner = true;
                                });

                                if (selectedIndex != null &&
                                    imageFile == null) {
                                  await _fireStore
                                      .collection('userDetails')
                                      .doc(loggedInUser)
                                      .update({'avatar': selectedIndex,'imageUrl':null});
                                } else if (imageFile != null &&
                                    selectedIndex == null) {
                                  //------------------------------
                                  await uploadPic(context);
                                  //-------------------------------
                                  await _fireStore
                                      .collection('userDetails')
                                      .doc(loggedInUser)
                                      .update({'imageUrl': downloadUrl,'avatar':null});
                                } else if (imageFile == null &&
                                    selectedIndex == null) {
                                }
                                await _fireStore
                                    .collection('userDetails')
                                    .doc(loggedInUser)
                                    .update({'gender': gender});
                                //-------------------------------------
                                SharedPreferences prefsName =
                                    await SharedPreferences.getInstance();
                                prefsName.setInt('gender', gender);
                                //-------------------------------------
                                Navigator.pop(context);
                                //-------------------------------------------
                                setState(() {
                                  spinner = false;
                                });
                                //-------------------------------------------
                              },
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Color(0xff004E6E),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
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
                      );
                    },
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
          });
        },
        child: CircleAvatar(
          child: Image.asset('images/avatar1.jpg'),
          radius: selectedIndex == 1 ? 50 : 30,
          backgroundColor: Colors.transparent,
        ),
      ),
      InkWell(
        onTap: () {
          setState(() {
            selectedIndex = 2;
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
