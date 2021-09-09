import 'package:flutter/material.dart';
import 'package:hafs/web_view/view.dart';

class ReusableVideoCard extends StatelessWidget {
  ReusableVideoCard({this.imageNumber, this.title, this.url});

  final int imageNumber;
  final String title, url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => View(
              title: title,
              url: url,
            ),
          ),
        );
      },
      child: Card(
        child: Image.asset(
          'images/video$imageNumber.jpg',
          height: 200,
          width: 200,
        ),
        color: Color(0xffEFFAFF),
      ),
    );
  }
}
