import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hafs/audio_play/audio.dart';
import 'package:hafs/auth/register.dart';
import 'package:hafs/home_screens/widgets/book_free_session.dart';
import 'package:hafs/home_screens/widgets/reusable_article_card.dart';
import 'package:hafs/home_screens/widgets/reusable_card.dart';
import 'package:hafs/home_screens/widgets/reusable_column.dart';
import 'package:hafs/home_screens/widgets/reusable_video_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int articles = 1, videos = 0, audio = 0;
  bool checkSession;

  checkFreeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    checkSession = prefs.getBool('freeSession');
    print('$checkSession *******************');
  }

  @override
  void initState() {
    setState(() {
      checkFreeSession();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return null;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Hi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Think Hafs, Think Quran',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
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
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Want to Learn:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Image.asset(
                                'images/cards.jpg',
                                width: double.infinity,
                                height: 300,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Register(),
                                    ),
                                  );
                                },
                                child: Image.asset('images/signup.jpg'),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              (checkSession == null || checkSession == false)
                                  ? BookFreeSession(goHome: true,)
                                  : SizedBox(),
                              // FlatButton(
                              //     onPressed: () async {
                              //       SharedPreferences prefs =
                              //           await SharedPreferences.getInstance();
                              //       prefs.remove('freeSession');
                              //     },
                              //     child: Text('clear')),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Explore Hafs Teachers & Students:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(child: SizedBox()),
                                  ReusableCard(
                                    text: 'Teachers',
                                    textColor: Color(0xff004E6E),
                                    cardColor: Color(0xffECF9FF),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ReusableCard(
                                    text: 'Students',
                                    textColor: Colors.white,
                                    cardColor: Color(0xff004E6E),
                                    onTap: () {},
                                  ),
                                  Expanded(child: SizedBox()),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ReusableColumn(
                                    imageNumber: 1,
                                    studentName: 'Ahmed Ali',
                                    wantToLearn: 'Tajweed',
                                  ),
                                  ReusableColumn(
                                    imageNumber: 2,
                                    studentName: 'Mohammed Ahmed',
                                    wantToLearn: 'Arabic',
                                  ),
                                  ReusableColumn(
                                    imageNumber: 4,
                                    studentName: 'Hanif Habib',
                                    wantToLearn: 'Tajweed',
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                            url: 'https://youtu.be/DyvW2Ag_l88',
                                            title: 'Quran in a minute | AR- RUM ',
                                            imageNumber: 1,
                                          ),
                                          ReusableVideoCard(
                                            url: 'https://youtu.be/68c8GPpGPdE',
                                            title: 'A real class experience',
                                            imageNumber: 2,
                                          ),
                                          ReusableVideoCard(
                                            url: 'https://youtu.be/nZO7e5k0SwE',
                                            title:
                                                'Quran in a minute | Al-Kawthar',
                                            imageNumber: 3,
                                          ),
                                          ReusableVideoCard(
                                            url: 'https://youtu.be/z4n0wmVhCEk',
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
}
