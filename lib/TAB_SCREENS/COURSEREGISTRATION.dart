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
  
   String caesarCipherDecrypt(String encryptedText, int shift) {
  String decryptedText = '';
  for (int i = 0; i < encryptedText.length; i++) {
    int charCode = encryptedText.codeUnitAt(i);
    if (charCode >= 65 && charCode <= 90) { // Uppercase letters
      charCode -= shift;
      if (charCode < 65) {
        charCode += 26;
      }
    } else if (charCode >= 97 && charCode <= 122) { // Lowercase letters
      charCode -= shift;
      if (charCode < 97) {
        charCode += 26;
      }
    }
    decryptedText += String.fromCharCode(charCode);
  }
  return decryptedText;
}
String regQrData = "";
  Map<String, dynamic> map = {};
  Future<void> _getData() async {
    try {
      final result = await BarcodeScanner.scan();
      setState(() {
        regQrData = result.rawContent;
       
        map = json.decode(regQrData.replaceAll("'", '"')); 
        String decryptedText = caesarCipherDecrypt(regQrData, 3);
        if (map['data'] == "${DateTime.now().year} registration form") {
          regQrData = "found";
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
