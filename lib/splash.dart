import 'package:flutter/material.dart';
import 'package:hafs/auth/login.dart';
import 'package:hafs/home_screens/screens/home.dart';

class SplashActivity extends StatefulWidget {
  @override
  _SplashActivityState createState() => _SplashActivityState();
}

class _SplashActivityState extends State<SplashActivity> {

  void initState(){
    super.initState();

    _mockCheckForSession().then(
            (status) {
          if (status){
            _navigateToHome();
          }
        }
    );
  }

  Future<bool> _mockCheckForSession() async {

    await Future.delayed(Duration(milliseconds: 5000), () {} );

    return false;

  }

  void  _navigateToHome(){

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => Home(),
        )
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E4F6F),
      body: Center(
        child: Image.asset('images/logo.png'),
      ),
    );
  }
}