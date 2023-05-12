// ignore_for_file: avoid_unnecessary_containers, duplicate_ignore, unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/TAB_SCREENS/Chat.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:flutter_application_1/widget/bottombar_widget.dart';
import 'package:get/get.dart';
import 'SlideBar.dart';

import '../TAB_SCREENS/Channel.dart';
import '../TAB_SCREENS/Home.dart';
import '../TAB_SCREENS/Notificatons.dart';

// import '../utils/global.colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // final String id = Get.arguments[2].obs;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
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
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: IconButton(
                  icon: Icon(
                    Icons.account_circle_outlined,
                    color: Colors.black,
                    size: 35,
                  ),
                  onPressed: null),
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
              child: Text("afd00"),
              onTap: (() {
                print("tappd");
              }),
            )
          ],
        ),
        bottomNavigationBar: const BottombarWidget(),
      ),
    );
  }
}
