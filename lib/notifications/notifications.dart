import 'package:flutter/material.dart';
import 'package:hafs/home_screens/widgets/reusable_bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';


class Notifications extends StatelessWidget {
  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
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
                    'Notifications',
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
                            padding: EdgeInsets.all(15),
                            children: [
                              InkWell(
                                onTap: ()async {
                             _launchURL('https://us02web.zoom.us/j/82132271883?pwd=RWtxWG13cWw1RW5kcE1LeDREUTM3QT09');
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(bottom: 15),
                                  color: Color(0xffECF9FF),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        child: Icon(
                                          Icons.videocam_rounded,
                                          color: Color(0xff4385A7),
                                        ),
                                        backgroundColor: Color(0xffBFE9FF),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'You have a live session today: 2 pm',
                                            style: TextStyle(
                                                color: Color(0xff4385A77),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 10,),
                                          Text('press to launch meeting',style: TextStyle(
                                            color: Color(0xFF1E3685),
                                            fontSize: 15,
                                            decoration: TextDecoration.underline,
                                            fontWeight: FontWeight.bold,
                                          ),)
                                        ],
                                      ),
                                      Text(
                                        'Today',
                                        style: TextStyle(
                                            color: Color(0xff4385A7), fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(bottom: 15),
                                color: Color(0xffECF9FF),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.check,
                                        color: Color(0xff4385A7),
                                      ),
                                      backgroundColor: Color(0xffBFE9FF),
                                    ),
                                    Text(
                                      'Youssef Mohamed has agreed \nto your invitation',
                                      style: TextStyle(
                                          color: Color(0xff4385A77),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '1 day ago',
                                      style: TextStyle(
                                          color: Color(0xff4385A7), fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(bottom: 15),
                                color: Color(0xffECF9FF),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.edit,
                                        color: Color(0xff4385A7),
                                      ),
                                      backgroundColor: Color(0xffBFE9FF),
                                    ),
                                    Text(
                                      'You have Tajweed home work\n to do',
                                      style: TextStyle(
                                          color: Color(0xff4385A77),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '2 days ago',
                                      style: TextStyle(
                                          color: Color(0xff4385A7), fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(bottom: 15),
                                color: Color(0xffECF9FF),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.star_border,
                                        color: Color(0xff4385A7),
                                      ),
                                      backgroundColor: Color(0xffBFE9FF),
                                    ),
                                    Text(
                                      'Mohamed Magdy gave you\n100 points',
                                      style: TextStyle(
                                          color: Color(0xff4385A77),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '3 days ago',
                                      style: TextStyle(
                                          color: Color(0xff4385A7), fontSize: 14),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        ReusableBottomBar(homeNew: false,messages: false,notifications: true,profile: false,)
                      ],
                    )),
              ),

            ],
          )),
    );
  }
}
