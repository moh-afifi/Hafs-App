import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'file:///C:/flutterProjects/projects/hafs/hafs/lib/audio_play/audio.dart';
import 'package:hafs/home_screens/widgets/book_free_session.dart';
import 'package:hafs/home_screens/widgets/reusable_article_card.dart';
import 'package:hafs/home_screens/widgets/reusable_bottom_bar.dart';
import 'package:hafs/home_screens/widgets/reusable_card.dart';
import 'package:hafs/home_screens/widgets/reusable_teacher_card.dart';
import 'package:hafs/home_screens/widgets/reusable_video_card.dart';
import 'file:///C:/flutterProjects/projects/hafs/hafs/lib/messages/messages.dart';
import 'file:///C:/flutterProjects/projects/hafs/hafs/lib/notifications/notifications.dart';
import 'package:hafs/profile/profile_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeNew extends StatefulWidget {
  @override
  _HomeNewState createState() => _HomeNewState();
}

class _HomeNewState extends State<HomeNew> {
  int articles = 1, videos = 0, audio = 0, avatar;
  String imageUrl;
  var _fireStore = FirebaseFirestore.instance;
  var _auth = FirebaseAuth.instance;
  var loggedInUser;
  bool checkSession = true;

  checkFreeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    checkSession = prefs.getBool('freeSession');
    print(checkSession);
  }

  getCurrentUser() {
    User user = _auth.currentUser;
    loggedInUser = user.email;
    print('$loggedInUser **************');
  }

  //-----------------------------------------
  @override
  void initState() {
    setState(() {
      getCurrentUser();
      checkFreeSession();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return null;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF1E3685),
          body: StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection('userDetails').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox();
                }
                var items = snapshot.data.docs;
                String name;
                for (var item in items) {
                  if (loggedInUser == item.get('email')) {
                    name = item.get('name');
                    avatar = item.get('avatar');
                    imageUrl = item.get('imageUrl');
                  }
                }
                return Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: 70,
                            width: 70,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Hi, $name',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  ' 150 Points',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffFFF45A),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Next Class : Sat,22 Nov',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xffBFE9FF),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 45,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Time Table',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xffBFE9FF),
                          ),
                        ),
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width * 0.7,
                          lineHeight: 14.0,
                          percent: 0.5,
                          progressColor: Colors.blue,
                          linearGradient: LinearGradient(
                            colors: [Colors.blue,Colors.white]
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '3/6 ',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'after 6 hours 40 minutes',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      indent: 50,
                      endIndent: 50,
                      color: Colors.black,
                      thickness: 5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          'Homework:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Color(0xffBFE9FF),
                          ),
                        ),
                        Text(
                          'TAJWEED',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'with',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Color(0xffBFE9FF),
                          ),
                        ),
                        Text(
                          'MOHAMMED MAGDY',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView(
                                padding: EdgeInsets.all(12),
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Best Tajweed Teacher',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'Edit Interest',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color(0xff4385A7),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Based on your Interest',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color(0xff8D8D8D),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ReusableTeacherCard(
                                        imageNumber: 1,
                                        teacherName: 'Mohammed Magdy',
                                      ),
                                      ReusableTeacherCard(
                                        imageNumber: 2,
                                        teacherName: 'Abdulaziz Kassem',
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  (checkSession == null ||
                                          checkSession == false)
                                      ? BookFreeSession(goHome: false,)
                                      : SizedBox(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Articles,videos & audios',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ReusableCard(
                                        onTap: () {
                                          setState(() {
                                            articles = 1;
                                            videos = 0;
                                            audio = 0;
                                          });
                                        },
                                        text: 'Articles',
                                        textColor: (articles == 1 &&
                                                videos == 0 &&
                                                audio == 0)
                                            ? Colors.white
                                            : Color(0xff004E6E),
                                        cardColor: (articles == 1 &&
                                                videos == 0 &&
                                                audio == 0)
                                            ? Color(0xff004E6E)
                                            : Color(0xffBFE9FF),
                                      ),
                                      ReusableCard(
                                        onTap: () {
                                          setState(() {
                                            articles = 0;
                                            videos = 1;
                                            audio = 0;
                                          });
                                        },
                                        text: 'Videos',
                                        textColor: (articles == 0 &&
                                                videos == 1 &&
                                                audio == 0)
                                            ? Colors.white
                                            : Color(0xff004E6E),
                                        cardColor: (articles == 0 &&
                                                videos == 1 &&
                                                audio == 0)
                                            ? Color(0xff004E6E)
                                            : Color(0xffBFE9FF),
                                      ),
                                      ReusableCard(
                                        onTap: () {
                                          setState(() {
                                            articles = 0;
                                            videos = 0;
                                            audio = 1;
                                          });
                                        },
                                        text: 'Audio',
                                        textColor: (articles == 0 &&
                                                videos == 0 &&
                                                audio == 1)
                                            ? Colors.white
                                            : Color(0xff004E6E),
                                        cardColor: (articles == 0 &&
                                                videos == 0 &&
                                                audio == 1)
                                            ? Color(0xff004E6E)
                                            : Color(0xffBFE9FF),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  (articles == 1 && videos == 0 && audio == 0)
                                      ? SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              ReusableArticleCard(
                                                title: 'What do we Offer?',
                                                url:
                                                    'https://hafsquran.com/articles/i7zypvqCTiCl3agar1JD',
                                              ),
                                              ReusableArticleCard(
                                                title: 'Our Story',
                                                url:
                                                    'https://hafsquran.com/articles/8RBje0w3hOyacyH2tzya',
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox(),
                                  (articles == 0 && videos == 1 && audio == 0)
                                      ? SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              ReusableVideoCard(
                                                url:
                                                    'https://youtu.be/DyvW2Ag_l88',
                                                title:
                                                    'Quran in a minute | AR- RUM ',
                                                imageNumber: 1,
                                              ),
                                              ReusableVideoCard(
                                                url:
                                                    'https://youtu.be/68c8GPpGPdE',
                                                title:
                                                    'A real class experience',
                                                imageNumber: 2,
                                              ),
                                              ReusableVideoCard(
                                                url:
                                                    'https://youtu.be/nZO7e5k0SwE',
                                                title:
                                                    'Quran in a minute | Al-Kawthar',
                                                imageNumber: 3,
                                              ),
                                              ReusableVideoCard(
                                                url:
                                                    'https://youtu.be/z4n0wmVhCEk',
                                                title: 'Sura AL-naba',
                                                imageNumber: 4,
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox(),
                                  (articles == 0 && videos == 0 && audio == 1)
                                      ? Column(
                                          children: [
                                            AudioPlayerUrl(),
                                            Text(
                                              'Al-Fateha',
                                              style: TextStyle(
                                                color: Color(0xff004E6E),
                                              ),
                                            )
                                          ],
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                            ReusableBottomBar(homeNew: true,messages: false,notifications: false,profile: false,)
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
