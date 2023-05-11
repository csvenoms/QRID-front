// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

import 'package:flutter_application_1/TAB_SCREENS/My_Account.dart';
import 'package:get/get.dart';
import '../TAB_SCREENS/AboutUs.dart';
import '../TAB_SCREENS/CourseRegister.dart';
import '../TAB_SCREENS/Result.dart';
import '../TAB_SCREENS/Saved.dart';
import '../TAB_SCREENS/setting.dart';

class SlideBar extends StatelessWidget {
  const SlideBar({super.key});
  void getData() {}
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "${Get.arguments[0]} ${Get.arguments[1]}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text("${Get.arguments[2]}"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/logo/gatedoor.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Information'),
            hoverColor: Colors.grey,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyAccount()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.app_registration_outlined),
            title: Text('Course Registration'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CourseRegister()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Result'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Result()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Saved'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Saved()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_applications),
            title: Text('Setting'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Setting()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUs()),
              );
            },
          ),
        ],
      ),
    );
  }
}
