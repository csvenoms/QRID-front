import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/global.colors.dart';
import 'package:flutter_application_1/view/home.view.dart';
import 'package:flutter_application_1/view/login.view.dart';
import 'package:flutter_application_1/view/sharedPreference.dart';
import 'package:get/get.dart';

import '../MODELS/ann.dart';
import '../TAB_SCREENS/COURSEREGISTRATION.dart';

// ignore: use_key_in_widget_constructors
class SplashView extends StatefulWidget {
  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  Alignment alignment = Alignment.center;
  late String name, id, batch, dept;
  @override
  void initState() {
    AuthTokenSave.getFullName().then((value) {
      setState(() {
        name = value ?? "";
      });
    });
    AuthTokenSave.getbatch().then((value) {
      setState(() {
        batch = value ?? "";
      });
    });
    AuthTokenSave.getId().then((value) {
      setState(() {
        id = value ?? "";
      });
    });
    AuthTokenSave.getDept().then((value) {
      setState(() {
        dept = value ?? "";
      });
    });
    Future.delayed(const Duration(seconds: 0)).then((value) {
      setState(() {
        alignment = Alignment.topCenter;
      });
    });
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      if (name == "" || id == "" || batch == "" || dept == "") {
        Get.to(LoginView());
      } else {
        Get.to(HomePage());
      }
    });
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: Stack(
        children: [
          Center(
            child: AnimatedAlign(
              alignment: alignment,
              duration: const Duration(seconds: 5),
              curve: Curves.easeInOut,
              child: Image.asset(
                'assets/logo/wku-logo.png',
                width: 150.0,
                height: 150.0,
              ),
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 120.0,
            child: Text(
              'JEFORE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Space Age',
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
