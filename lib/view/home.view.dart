// ignore_for_file: avoid_unnecessary_containers, duplicate_ignore, unused_import, prefer_const_constructors

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/TAB_SCREENS/Chat.dart';
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

  // final String id = Get.arguments[2].obs;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();
  String qrCodeResult = "Not Yet Scanned";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          // ignore: prefer_const_constructors
          drawer: SlideBar(),
          appBar: ScrollAppBar(
            // ignore: prefer_const_constructors

            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            controller: controller,
            backgroundColor: Colors.white,
            title: const Text(
              'JEFORE',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: 'Space Age',
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChangePassword(),
                                  ),
                                );
                              },
                              child: Text('Change Password'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Log out'),
                          ),
                        ],
                      ),
                    ),
                  ],
                  child: CircleAvatar(
                    child: ClipOval(),
                  ),
                ),
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
                    Tab(
                      icon: Icon(
                        Icons.notifications_none_outlined,
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
                          physics: null,
                          controller: controller,
                          child: const Home()),

                      // ignore: prefer_const_constructors
                      Chat(),
                      Notifications(),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                child: Text(""),
                onTap: (() {
                  print("tappd");
                }),
              )
            ],
          ),
          bottomNavigationBar: GestureDetector(
            
            child: Icon(Icons.qr_code_2_rounded, size: 40),
            onTap: () async {
              try {
                final result = await BarcodeScanner.scan();
                setState(() {
                  qrCodeResult = result.rawContent;
                });
              } catch (e) {
                Get.dialog(AlertDialog(
                  title: Text("error"),
                  content: Text("${e}"),
                  actions: <Widget>[
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ));
              }

              String jsonString =
                  qrCodeResult + '"stud_id":"' + Get.arguments[0] + '"}';

              jsonString = jsonString.replaceAll("'", "\"");
              Map<String, String> headers = {
                "Content-Type": "application/json; charset=UTF-8"
              };

             
              var url =
                  Uri.parse("${NetworkURL.URL}/instructor/attended");
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
