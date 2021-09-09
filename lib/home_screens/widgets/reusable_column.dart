import 'package:flutter/material.dart';

class ReusableColumn extends StatelessWidget {
  ReusableColumn({this.imageNumber,this.studentName,this.wantToLearn});
  final int imageNumber;
  final String studentName;
  final String wantToLearn;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          child: Image.asset('images/avatar$imageNumber.jpg'),
          radius: 30,
          backgroundColor: Colors.transparent,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          studentName,
          style: TextStyle(
              fontSize: 12,
              color: Color(0xff004E6E),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Want To Learn',
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          wantToLearn,
          style: TextStyle(
              fontSize: 10,
              color: Color(0xff004E6E),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
