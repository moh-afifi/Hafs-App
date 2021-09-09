import 'package:flutter/material.dart';
import 'file:///C:/flutterProjects/projects/hafs/hafs/lib/free_session/screens/free_session_three.dart';
import 'package:hafs/free_session/widgets/bottom_button.dart';

class FreeSessionTwo extends StatefulWidget {
  FreeSessionTwo({this.name, this.email, this.timeZone,this.goHome});

  final String name, email, timeZone;
  final bool goHome;

  @override
  _FreeSessionTwoState createState() => _FreeSessionTwoState();
}

class _FreeSessionTwoState extends State<FreeSessionTwo> {
  bool sat = false,
      sun = false,
      mon = false,
      tues = false,
      wed = false,
      thur = false,
      fri = false,
      from = false,
      other = false,
      showTextField = false;
  String answer, availability;
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
                              height: 10,
                            ),
                            Text(
                              'When you are available (On..) - From(.. to ..) :',
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
                                    value: sat,
                                    onChanged: (val) {
                                      setState(() {
                                        sat = val;
                                        sun = mon =
                                            tues = wed = thur = fri = false;
                                        availability = 'Saturday';
                                      });
                                    }),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Saturday',
                                  style: myTextStyle,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: sun,
                                    onChanged: (val) {
                                      setState(() {
                                        sun = val;
                                        sat = mon =
                                            tues = wed = thur = fri = false;
                                        availability = 'Sunday';
                                      });
                                    }),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Sunday',
                                  style: myTextStyle,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: mon,
                                    onChanged: (val) {
                                      setState(() {
                                        mon = val;
                                        sat = sun =
                                            tues = wed = thur = fri = false;
                                        availability = 'Monday';
                                      });
                                    }),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Monday',
                                  style: myTextStyle,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: tues,
                                    onChanged: (val) {
                                      setState(() {
                                        tues = val;
                                        sat = sun =
                                            mon = wed = thur = fri = false;
                                        availability = 'Tuesday';
                                      });
                                    }),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Tuesday',
                                  style: myTextStyle,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: wed,
                                    onChanged: (val) {
                                      setState(() {
                                        wed = val;
                                        sat = sun =
                                            mon = tues = thur = fri = false;
                                        availability = 'Wednesday';
                                      });
                                    }),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Wednesday',
                                  style: myTextStyle,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: thur,
                                    onChanged: (val) {
                                      setState(() {
                                        thur = val;
                                        sat = sun =
                                            mon = tues = wed = fri = false;
                                        availability = 'Thursday';
                                      });
                                    }),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Thursday',
                                  style:myTextStyle,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: fri,
                                    onChanged: (val) {
                                      setState(() {
                                        fri = val;
                                        sat = sun =
                                            mon = tues = wed = thur = false;
                                        availability = 'Friday';
                                      });
                                    }),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Friday',
                                  style:myTextStyle,
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: from,
                                    onChanged: (val) {
                                      setState(() {
                                        from = val;
                                        other = showTextField = false;
                                      });
                                    }),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'From 14:00 (pm) to 23:00 (pm)',
                                  style: myTextStyle,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: other,
                                    onChanged: (val) {
                                      setState(() {
                                        other = val;
                                        print(other);
                                        from = false;
                                        answer = null;
                                        showTextField = !showTextField;
                                      });
                                    }),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Other',
                                  style: myTextStyle,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            (showTextField)
                                ? TextField(
                                    onChanged: (val) {
                                      answer = val;
                                    },
                                    decoration: InputDecoration(
                                        filled: true,
                                        border: OutlineInputBorder(),
                                        fillColor: Color(0xFFE6F7FF),
                                        hintText: 'Typer your answer ..',
                                        hintStyle:
                                            TextStyle(color: Colors.blue)),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      BottomButton(
                        onTap: () {
                          if (availability == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please, choose a day !'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else if (from == false && other == false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please, choose a time !'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else if (from == false && answer == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please, enter a time !'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FreeSessionThree(
                                  name: widget.name,
                                  email: widget.email,
                                  timeZone: widget.timeZone,
                                  availability: availability,
                                  from: from,
                                  answer: answer,
                                  goHome: widget.goHome,
                                ),
                              ),
                            );
                          }
                        },
                        label: 'Next',
                      ),
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
