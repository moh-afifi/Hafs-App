import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'file:///C:/flutterProjects/projects/hafs/hafs/lib/free_session/screens/free_session_two.dart';
import 'package:hafs/free_session/widgets/bottom_button.dart';

class FreeSessionOne extends StatefulWidget {
  FreeSessionOne({this.goHome});
  final bool goHome;
  @override
  _FreeSessionOneState createState() => _FreeSessionOneState();
}

class _FreeSessionOneState extends State<FreeSessionOne> {
  var _formKey = GlobalKey<FormState>();
  String name, email, timeZone;
  var nameValidator = MultiValidator([
    RequiredValidator(errorText: 'name is required'),
  ]);
  var timeZoneValidator = MultiValidator([
    RequiredValidator(errorText: 'name is required'),
  ]);
  var emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    EmailValidator(errorText: 'email not valid'),
    PatternValidator(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
        errorText: 'email format not valid'),
  ]);

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
          body: Form(
            key: _formKey,
            child: Column(
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
                    height: double.infinity,
                    width: double.infinity,
                    //margin: EdgeInsets.only(top: 15),
                    //padding: EdgeInsets.symmetric(horizontal: 10),
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
                                height: 25,
                              ),
                              Text(
                                'Name:',
                                style: TextStyle(
                                  color: Color(0xff535353),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Put the child\'n name if it is your kid',
                                style: TextStyle(
                                  color: Color(0xffA5A5A5),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                onChanged: (val) {
                                  name = val;
                                },
                                validator: nameValidator,
                                decoration: InputDecoration(
                                    filled: true,
                                    labelText: 'Name',
                                    border: OutlineInputBorder(),
                                    fillColor: Color(0xFFE6F7FF),
                                    hintText: 'Name *',
                                    hintStyle: TextStyle(color: Colors.blue)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: emailValidator,
                                onChanged: (val) {
                                  email = val.trim();
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: 'Email Address',
                                  border: OutlineInputBorder(),
                                  fillColor: Color(0xFFE6F7FF),
                                  hintText: 'email *',
                                  hintStyle: TextStyle(color: Colors.blue),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: timeZoneValidator,
                                onChanged: (val) {
                                  timeZone = val;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: 'Time zone',
                                  border: OutlineInputBorder(),
                                  fillColor: Color(0xFFE6F7FF),
                                  hintText: 'Time Zone *',
                                  hintStyle: TextStyle(color: Colors.blue),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        BottomButton(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FreeSessionTwo(
                                    name: name,
                                    email: email,
                                    timeZone: timeZone,
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
      ),
    );
  }
}
