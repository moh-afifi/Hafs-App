import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'file:///C:/flutterProjects/projects/hafs/hafs/lib/free_session/screens/free_session_four.dart';
import 'package:hafs/free_session/widgets/bottom_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FreeSessionThree extends StatefulWidget {
  FreeSessionThree(
      {this.answer,
        this.availability,
      this.timeZone,
      this.email,
      this.name,
      this.from,
this.goHome
  });
  final String name, email, timeZone, answer,availability;
  final bool from,goHome;

  @override
  _FreeSessionThreeState createState() => _FreeSessionThreeState();
}

class _FreeSessionThreeState extends State<FreeSessionThree> {
  bool arabic = false, tajweed = false, pronun = false, memo = false, spinner =false;
  String learn;
  var _fireStore = FirebaseFirestore.instance;
  var myTextStyle= TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: Color(0xff4385A7),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff15B297),
              Color(0xff01A9F9),
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
                      'Free Session',
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffF3F3F3),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Please fill the following fields to have a free session with hafs',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                'Want to learn:',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff535353),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      value: arabic,
                                      onChanged: (val) {
                                        setState(() {
                                          arabic = val;
                                          tajweed=pronun=memo=false;
                                          learn='Arabic';
                                        });
                                      }),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Arabic',
                                    style: myTextStyle,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      value: tajweed,
                                      onChanged: (val) {
                                        setState(() {
                                          tajweed = val;
                                          arabic=pronun=memo=false;
                                          learn='Tajweed';
                                        });
                                      }),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Tajweed',
                                    style: myTextStyle,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      value: pronun,
                                      onChanged: (val) {
                                        setState(() {
                                          pronun = val;
                                          arabic=tajweed=memo=false;
                                          learn='Quran Correct Pronunciation';
                                        });
                                      }),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Quran Correct Pronunciation',
                                    style:myTextStyle,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      value: memo,
                                      onChanged: (val) {
                                        setState(() {
                                          memo = val;
                                          arabic=tajweed=pronun=false;
                                          learn='Quran memorization';
                                        });
                                      }),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Quran memorization',
                                    style: myTextStyle,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        BottomButton(
                          label: 'finish',
                          onTap: () async{
                            setState(() {
                              spinner=true;
                            });
                            await _fireStore
                                .collection('sessionDetails')
                                .doc(widget.email)
                                .set({
                              'timeZone': widget.timeZone,
                              'email': widget.email,
                              'name': widget.name,
                              'availability': widget.availability,
                              'timeToLearn': (widget.from)? 'From 14:00 (pm) to 23:00 (pm)':widget.answer,
                              'learn': learn,
                              'sort': DateTime.now().millisecondsSinceEpoch
                            });
                            //-----------------------------------------
                            SharedPreferences prefsName =
                            await SharedPreferences.getInstance();
                            prefsName.setBool('freeSession', true);
                            //-----------------------------------------
                            setState(() {
                              spinner=false;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FreeSessionFour(
                                  goHome: widget.goHome,
                                ),
                              ),
                            );
                          },
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
}
