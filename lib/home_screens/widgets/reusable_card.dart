import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({this.text,this.textColor,this.cardColor,this.onTap});
  final Color cardColor,textColor;
  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: textColor
            ),
          ),
        ),
        color: cardColor,
        elevation: 5,
      ),
    );
  }
}
