import 'package:flutter/material.dart';

class ReusableAvatar extends StatelessWidget {
  ReusableAvatar({this.onTap,this.radius,this.imageNumber});
  final Function onTap;
  final double radius;
  final int imageNumber;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        child: Image.asset('images/avatar$imageNumber.jpg'),
        radius: radius,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
