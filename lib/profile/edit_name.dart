import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EditName extends StatefulWidget {
  EditName({this.email});

  final String email;

  @override
  _EditNameState createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  var _fireStore = FirebaseFirestore.instance;

  bool spinner = false;
  String name;

  var _formKey = GlobalKey<FormState>();

  var nameValidator = MultiValidator([
    RequiredValidator(errorText: 'name is required'),
  ]);

  //----------------------------------------
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff1E3685),
              Color(0xffAB3FCF),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ModalProgressHUD(
            inAsyncCall: spinner,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
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
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Edit Name',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xff004E6E),
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
                                prefixIcon: Icon(Icons.person),
                                hintText: 'Name *',
                                hintStyle: TextStyle(color: Colors.blue)),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          InkWell(
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                var connectivityResult = await (Connectivity()
                                    .checkConnectivity());
                                if (connectivityResult !=
                                        ConnectivityResult.mobile &&
                                    connectivityResult !=
                                        ConnectivityResult.wifi) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('no internet connection'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    spinner = true;
                                  });
                                  await _fireStore
                                      .collection('userDetails')
                                      .doc(widget.email)
                                      .update({'name': name});
                                  setState(() {
                                    spinner = false;
                                  });
                                  Navigator.pop(context);
                                }
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Color(0xff004E6E),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
