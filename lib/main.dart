import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hafs/auth/login.dart';
import 'package:hafs/auth/register.dart';
import 'package:hafs/belal/belal_1.dart';
import 'package:hafs/home_screens/screens/home.dart';
import 'package:hafs/home_screens/screens/home_new.dart';
import 'package:hafs/provider_model/model_class.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  runApp(
    ChangeNotifierProvider<ModelProvider>(
      create: (context) => ModelProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
       // home: email == null ? Register() : Register(),
        home: HomeNew(),
      ),
    ),
  );
}


