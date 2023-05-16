// ignore_for_file: file_names, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../utils/global.colors.dart';

class MyAccount extends StatelessWidget {
  MyAccount({super.key});
  String idNo = Get.arguments[2];
  String name = "${Get.arguments[0]} ${Get.arguments[1]}";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      appBar: AppBar(
        // ignore: prefer_const_constructors
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'My Information',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Space Age',
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1)),
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage('null'),
                              )),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 4, color: Colors.white),
                                color: Colors.white),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Your name',
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(
                      text: name,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Your ID',
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(
                      text: idNo,
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 300,
                    child: Center(
                      child: QrImage(
                        data: this.idNo,
                        size: 250.0, // set the size of the QR image here
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
