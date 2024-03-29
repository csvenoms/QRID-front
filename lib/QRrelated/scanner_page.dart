// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../MODELS/Post.dart';
import '../utils/global.colors.dart';
import 'package:http/http.dart' as http;

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String qrCodeResult = "Not Yet Scanned";

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      key: key,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'SCAN QR-CODE',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Space Age',
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // qr code image

            const SizedBox(
              height: 25.0,
            ),

            GestureDetector(
              onLongPress: () {},
              child: SelectableText(
                qrCodeResult,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                cursorColor: Colors.red,
                showCursor: true,
                toolbarOptions: const ToolbarOptions(
                  copy: true,
                  cut: true,
                  paste: true,
                  selectAll: true,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            (qrCodeResult != "Not Yet Scanned")
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      child: Text(
                        "Scanned Successfully",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      onTap: () async {
                        String jsonString = qrCodeResult +
                            '"stud_id":"' +
                            Get.arguments[0] +
                            '"}';

                        jsonString = jsonString.replaceAll("'", "\"");
                        Map<String, String> headers = {
                          "Content-Type": "application/json; charset=UTF-8"
                        };

                        Get.dialog(
                          AlertDialog(
                            title: Text('Alert'),
                            content: Text(jsonString),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        );
                        var url = Uri.parse(
                            "${NetworkURL.URL}/instructor/attended");
                        var resp = await http.post(url,
                            headers: headers, body: jsonString);
                        if (resp.statusCode == 200) {
                          Get.snackbar("success", 'data sent successfully',
                              backgroundColor: Colors.green,
                              colorText: Colors.white);
                        } else {
                          Get.dialog(
                            AlertDialog(
                              title: Text('Alert'),
                              content: Text(resp.body),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  )
                : Column(children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 20.0),
                      height: 68.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(
                              32.0,
                            ),
                          ),
                        ),
                        onPressed: _scanBarcode,
                        child: const Text(
                          "Get Attendance",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ]),
          ],
        ),
      ),
    );
  }

  void _scanBarcode() async {
    try {
      final result = await BarcodeScanner.scan();
      setState(() {
        qrCodeResult = result.rawContent;
      });
    } catch (e) {
      // Handle error
    }
  }
}
