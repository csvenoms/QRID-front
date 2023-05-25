import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/MODELS/Post.dart';
import 'package:flutter_application_1/TAB_SCREENS/regForm.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../utils/global.colors.dart';
import 'dart:core';
import 'package:http/http.dart' as http;

class RegisterCourse extends StatefulWidget {
  const RegisterCourse({super.key});

  @override
  State<RegisterCourse> createState() => _RegisterCourseState();
}

class _RegisterCourseState extends State<RegisterCourse> {
  
  
String regQrData = "";
  Map<String, dynamic> map = {};
  Future<void> _getData() async {
    try {
      final result = await BarcodeScanner.scan();
      setState(() {
        regQrData = result.rawContent;
        map = json.decode(regQrData.replaceAll("'", '"'));
        if (map['data'] == "2023 registration form") {
          regQrData = "2nd";
        }
      });
    } catch (e) {
      Get.dialog(AlertDialog(
        content: Text("data not correct"),
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalColors.mainColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: const Text(
            'Course Registration',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Space Age',
            ),
          ),
          centerTitle: true,
        ),
        body: (regQrData != "")
            ? (const Forms())
            : (Center(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all()),
                  child: GestureDetector(
                      child: const Text("Scan QR",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      onTap: () async {
                        _getData();
                      }),
                ),
              )));
  }
}
