import 'package:flutter/material.dart';

class ModelProvider extends ChangeNotifier{

  String name,email,password ;
  String newName,newEmail;
  bool goHome;
  //-----------------------------
  void goHomeFunc(bool val){
    goHome=val;
    notifyListeners();
  }
  void changeName(String val){
    name=val;
    notifyListeners();
  }
  void changeEmail(String val){
    email=val;
    notifyListeners();
  }
  void changePassword(String val){
    password=val;
    notifyListeners();
  }
  void changeNewName(String val){
    newName=val;
    notifyListeners();
  }
  void changeNewEmail(String val){
    newEmail=val;
    notifyListeners();
  }

}