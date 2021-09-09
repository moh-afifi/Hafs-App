import 'package:flutter/material.dart';
import 'package:hafs/free_session/screens/free_session_one.dart';
class BookFreeSession extends StatelessWidget {
  BookFreeSession({this.goHome});
  final bool goHome;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FreeSessionOne(goHome: goHome,),
          ),
        );
      },
      child: Container(
        margin:
        EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff15B297),
              Color(0xff01A9F9),
            ],
          ),
        ),
        child: Center(
          child: Text(
            'Book a Free Session',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
