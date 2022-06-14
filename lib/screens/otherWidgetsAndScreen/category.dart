// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:aid_first/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:aid_first/animations/fade_animation.dart';
import 'package:aid_first/animations/bottom_animation.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: const Text(
                "Exit Application",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: const Text("Are You Sure?"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                FlatButton(
                  shape: const StadiumBorder(),
                  color: Colors.white,
                  child: const Text(
                    "No",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  shape: const StadiumBorder(),
                  color: Colors.white,
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    exit(0);
                  },
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: height * 0.065,
              ),
              FadeAnimation(
                0.3,
                Container(
                  margin: EdgeInsets.only(left: width * 0.05),
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Category',
                        style: TextStyle(
                            color: Colors.black, fontSize: height * 0.04),
                      ),
                      FlatButton(
                        shape: const CircleBorder(),
                        onPressed: () =>
                            Navigator.pushNamed(context, Routes.ABOUT_US),
                        child: Icon(
                          Icons.info,
                          size: height * 0.04,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.09),
              Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.2),
                    radius: height * 0.075,
                    child: Image(
                      image: const AssetImage("assets/doctor.png"),
                      height: height * 0.2,
                    ),
                  ),
                  WidgetAnimator(patDocBtn('Doctor', context)),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.2),
                    radius: height * 0.075,
                    child: Image(
                      image: const AssetImage("assets/patient.png"),
                      height: height * 0.2,
                    ),
                  ),
                  WidgetAnimator(patDocBtn('Patient', context)),
                  SizedBox(
                    height: height * 0.13,
                  ),
                  Column(
                    children: const <Widget>[
                      Text(
                        'Version',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'V 0.1',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget patDocBtn(String categoryText, context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.5,
      child: RaisedButton(
        onPressed: () {
          if (categoryText == 'Doctor') {
            Navigator.pushNamed(context, '/DoctorLogin');
          } else {
            Navigator.pushNamed(context, Routes.PATIENT_LOGIN);
          }
        },
        color: Colors.white,
        child: Text("I am " + categoryText),
        shape: const StadiumBorder(),
      ),
    );
  }
}
