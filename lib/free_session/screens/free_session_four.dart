import 'package:flutter/material.dart';
import 'package:hafs/free_session/widgets/bottom_button.dart';
import 'package:hafs/home_screens/screens/home.dart';
import 'package:hafs/home_screens/screens/home_new.dart';
import 'package:hafs/provider_model/model_class.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FreeSessionFour extends StatefulWidget {
  FreeSessionFour({this.goHome});
  final bool goHome;

  @override
  _FreeSessionFourState createState() => _FreeSessionFourState();
}

class _FreeSessionFourState extends State<FreeSessionFour> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // a method used to schedule a notification:
  Future notifySchedule(String payload) async{
    var scheduledNotificationDateTime = new DateTime.now().add(new Duration(seconds: 5));
    var android = new AndroidNotificationDetails('channel id',
        'channel NAME', 'CHANNEL DESCRIPTION');
    var iOS = new IOSNotificationDetails();
    NotificationDetails platform = new NotificationDetails(android: android,iOS: iOS);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Hafs Quran',
        'You have booked a free session!',
        scheduledNotificationDateTime, platform,payload:payload );
  }

  @override
  void initState() {
    super.initState();

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android: android,iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,onSelectNotification: notifySchedule);

  }
  //-----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<ModelProvider>(context);
    return WillPopScope(
      onWillPop: (){
        return null;
      },
      child: SafeArea(
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
            body: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Free Session',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: Container(
                    //margin: EdgeInsets.only(top: 15),
                    //padding: EdgeInsets.symmetric(horizontal: 10),
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
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              Icon(
                                Icons.check_circle_outline,
                                color: Colors.teal,
                                size: 100,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: Text(
                                  'Thanks For Register with us in a free session',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  'We will contact with you soon',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        BottomButton(
                          onTap: ()  async{
                            (widget.goHome)?myProvider.goHomeFunc(true):myProvider.goHomeFunc(false);
                            //--------------------------------------
                            (myProvider.goHome)? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ),
                            ):Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeNew(),
                              ),
                            );
                            await  notifySchedule('You have booked a free session!');
                            //-----------------------------------------
                          },
                          label: 'Home',
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
