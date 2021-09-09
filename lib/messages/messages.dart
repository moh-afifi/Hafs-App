import 'package:flutter/material.dart';
import 'package:hafs/home_screens/widgets/reusable_bottom_bar.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff004E6E),
        body: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff004E6E),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Invites',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Past Teacher',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
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
                          padding: EdgeInsets.all(15),
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xffBFE9FF),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xffBFE9FF),
                                    backgroundImage:
                                        AssetImage('images/teacher3.png'),
                                    radius: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Youssef Mohamed',
                                            style: TextStyle(
                                                color: Color(0xff004E6E),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          Text(
                                            'Today',
                                            style: TextStyle(
                                                color: Color(0xff4385A7),
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'We will start the new session tomorrow',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xffBFE9FF),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xffBFE9FF),
                                    backgroundImage:
                                        AssetImage('images/teacher4.png'),
                                    radius: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Mohamed Magdy',
                                            style: TextStyle(
                                                color: Color(0xff004E6E),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          Text(
                                            'Today',
                                            style: TextStyle(
                                                color: Color(0xff4385A7),
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'We will start the new session tomorrow',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xffE9E9E9),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xffBFE9FF),
                                    backgroundImage:
                                        AssetImage('images/teacher5.png'),
                                    radius: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Youssef Mohamed',
                                            style: TextStyle(
                                                color: Color(0xff004E6E),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          Text(
                                            'Today',
                                            style: TextStyle(
                                                color: Color(0xff4385A7),
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'We will start the new session tomorrow',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xffE9E9E9),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xffBFE9FF),
                                    backgroundImage:
                                        AssetImage('images/teacher6.png'),
                                    radius: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Shihab Nour',
                                            style: TextStyle(
                                                color: Color(0xff004E6E),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          Text(
                                            'Today',
                                            style: TextStyle(
                                                color: Color(0xff4385A7),
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'We will start the new session tomorrow',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ReusableBottomBar(
                        homeNew: false,
                        messages: true,
                        notifications: false,
                        profile: false,
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
