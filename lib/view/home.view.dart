// ignore_for_file: avoid_unnecessary_containers, duplicate_ignore, unused_import, prefer_const_constructors
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/TAB_SCREENS/Chat.dart';
import 'package:flutter_application_1/view/login.view.dart';
import 'package:flutter_application_1/view/sharedPreference.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:flutter_application_1/widget/bottombar_widget.dart';
import 'package:get/get.dart';
import '../MODELS/Post.dart';
import '../TAB_SCREENS/ChangePassword.dart';
import 'SlideBar.dart';

import '../TAB_SCREENS/Channel.dart';
import '../TAB_SCREENS/Home.dart';
import '../TAB_SCREENS/Notificatons.dart';
import 'package:http/http.dart' as http;
// import '../utils/global.colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();
  String qrCodeResult = "Not Yet Scanned";
  late String batch, department, id, token;
  @override
  void initState() {
    AuthTokenSave.getAuthenticationToken().then((value) {
      setState(() {
        token = value ?? "na token found";
      });
    });
    AuthTokenSave.getbatch().then((value) {
      setState(() {
        batch = value ?? "na token found";
      });
    });
    AuthTokenSave.getId().then((value) {
      setState(() {
        id = value ?? "na id found";
      });
    });
    AuthTokenSave.getDept().then((value) {
      setState(() {
        department = value ?? "no dept found";
      });
    });
    super.initState();
  }

  String caesarCipherDecrypt(String encryptedText, int shift) {
    String decryptedText = '';
    for (int i = 0; i < encryptedText.length; i++) {
      int charCode = encryptedText.codeUnitAt(i);
      if (charCode >= 65 && charCode <= 90) {
        // Uppercase letters
        charCode -= shift;
        if (charCode < 65) {
          charCode += 26;
        }
      } else if (charCode >= 97 && charCode <= 122) {
        // Lowercase letters
        charCode -= shift;
        if (charCode < 97) {
          charCode += 26;
        }
      }
      decryptedText += String.fromCharCode(charCode);
    }
    return decryptedText;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          // ignore: prefer_const_constructors
          drawer: SideBar(),
          appBar: ScrollAppBar(
            // ignore: prefer_const_constructors

            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            controller: controller,
            backgroundColor: Colors.white,
            title: Text(
              'JEFORE',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: 'Space Age',
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  final logoutUrl = '${NetworkURL.URL}/api_logout';

                  final response = await http.post(Uri.parse(logoutUrl),
                      headers: {'Authorization': 'Token $token'});

                  if (response.statusCode == 200) {
                    AuthTokenSave.clearAuthenticationData();
                    Get.offAll(LoginView()); // Handle successful logout
                  } else {
                    Get.dialog(
                      AlertDialog(
                        title: Text('Alert'),
                        content: Text('${response.statusCode}'),
                        actions: [
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
            ],
          ),
          body: Column(
            children: [
              Container(
                child: const TabBar(
                
                  labelPadding: EdgeInsets.all(1),
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.home_outlined,
                        color: Colors.black,
                        size: 35,
                      ),
                      // onPressed: null
                    ),
                    
                    Tab(
                      icon: Icon(
                        Icons.chat_outlined,
                        color: Colors.black,
                        size: 35,
                      ),
                      // onPressed: null
                    ),
                   
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(
                          physics: null, controller: controller, child: Home()),
                      // ignore: prefer_const_constructors
                     MessageScreen(),
                     
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: GestureDetector(
            child: Icon(Icons.qr_code_2_rounded, size: 40),
            onTap: () async {
              try {
                final result = await BarcodeScanner.scan();
                setState(() {
                  qrCodeResult = result.rawContent;
                  qrCodeResult = caesarCipherDecrypt(qrCodeResult, 3);
                });
              } catch (e) {}

              String jsonString = qrCodeResult + '"stud_id":"' + "$id" + '"}';

              jsonString = jsonString.replaceAll("'", "\"");

              final jsonObject = jsonDecode(jsonString);
              if (batch != jsonObject['year'] ||
                  department != jsonObject['targetGroup']) {
                Get.dialog(AlertDialog(
                  title: Text("Attendance Error"),
                  content: Text(
                      "The attendance is not for $batch year $department students!"),
                ));
                return;
              }
              DateTime now = DateTime.now();
              final formatter = DateFormat('yyyy-MM-dd');
              final formattedDate = formatter.format(now);

              if (jsonObject['date'] != "$formattedDate") {
                Get.dialog(AlertDialog(
                  title: Text("Attendance Error"),
                  content:
                      Text("The attendance form is expired or not correct!"),
                ));
                return;
              }
              Map<String, String> headers = {
                "Content-Type": "application/json; charset=UTF-8"
              };

              var url = Uri.parse("${NetworkURL.URL}/instructor/attended");
              var resp =
                  await http.post(url, headers: headers, body: jsonString);
              if (resp.statusCode == 200) {
                Get.snackbar("success", 'data sent successfully',
                    backgroundColor: Colors.green, colorText: Colors.white);
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
          )),
    );
  }
}
