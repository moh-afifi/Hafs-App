import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hafs/home_screens/screens/home.dart';
import 'package:hafs/home_screens/widgets/reusable_bottom_bar.dart';
import 'package:hafs/profile/profile_settings.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name, email, imageUrl;
  int avatar;
  var _fireStore = FirebaseFirestore.instance;
  var _auth = FirebaseAuth.instance;
  var loggedInUser;

  getCurrentUser() {
    User user = _auth.currentUser;
    loggedInUser = user.email;
    print('$loggedInUser **************');
  }

  @override
  void initState() {
    setState(() {
      // getName();
      // getEmail();
      getCurrentUser();
    });
    super.initState();
  }

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
          body: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileSettings(),
                        ),
                      );
                    },
                    icon: Icon(Icons.settings),
                    color: Colors.white,
                    iconSize: 40,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: _fireStore.collection('userDetails').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox();
                    }
                    var items = snapshot.data.docs;
                    for (var item in items) {
                      if (loggedInUser == item.get('email')) {
                        name = item.get('name');
                        email = item.get('email');
                        avatar = item.get('avatar');
                        imageUrl = item.get('imageUrl');
                      }
                    }
                    return Column(
                      children: [
                        Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: (avatar == null)
                                    ? NetworkImage(
                                        imageUrl,
                                      )
                                    : AssetImage('images/avatar$avatar.jpg'),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(80),
                              ),
                            ),
                            child: null),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$name',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$email',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  }),
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
                              'TO DO & Progress',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff8D8D8D),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Progress',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width * 0.9,
                              lineHeight: 14.0,
                              percent: 0.6,
                              progressColor: Colors.blue,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Homework',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'TAJWEED   with   MOHAMMED MAGDY',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff004E6E),
                              ),
                            ),
                            Divider(),
                            Row(
                              children: [
                                Text(
                                  'Location',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff8D8D8D),
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                                Text(
                                  'London',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff004E6E),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.arrow_forward_ios)
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Time Zone',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff8D8D8D),
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                                Text(
                                  'Eastern Standard time',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff004E6E),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.arrow_forward_ios)
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Plans & Pricing',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff8D8D8D),
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                                Text(
                                  'No Plan',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff004E6E),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.arrow_forward_ios)
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.remove('email');
                                //-----------------------------------------
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ),
                                );
                                //-----------------------------------------
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Log Out',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      ReusableBottomBar(homeNew: false,messages: false,notifications: false,profile: true,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
