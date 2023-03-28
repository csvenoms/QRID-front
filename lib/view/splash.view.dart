import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/global.colors.dart';
import 'package:flutter_application_1/view/login.view.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
class SplashView extends StatefulWidget {
  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  Alignment alignment = Alignment.center;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0)).then((value) {
      setState(() {
        alignment = Alignment.topCenter;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Get.to(const LoginView());
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
                fontFamily:'Space Age',
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