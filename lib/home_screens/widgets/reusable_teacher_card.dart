import 'package:flutter/material.dart';

class ReusableTeacherCard extends StatelessWidget {
  ReusableTeacherCard({this.teacherName,this.imageNumber});
  final String teacherName;
  final int imageNumber;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      teacherName,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Rating:',
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff4385A7)),
                        ),
                        Text(
                          '4.5 stars -',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff4385A7)),
                        ),
                        Text(
                          '8\$/hr',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Recitation',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff4385A7),
                          ),
                        ),
                        Icon(
                          Icons.play_circle_fill_outlined,
                          color: Color(0xff004E6E),
                        ),
                      ],
                    )
                  ],
                )),
          ],
        ),
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('images/teacher$imageNumber.png'),
        ),
      ],
    );
  }
}
