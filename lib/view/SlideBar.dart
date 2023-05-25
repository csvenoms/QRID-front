// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

import 'package:flutter_application_1/TAB_SCREENS/My_Account.dart';
import 'package:flutter_application_1/view/sharedPreference.dart';
import 'package:get/get.dart';
import '../TAB_SCREENS/COURSEREGISTRATION.dart';
import '../TAB_SCREENS/AboutUs.dart';
import '../TAB_SCREENS/Result.dart';
import '../TAB_SCREENS/Saved.dart';
import '../TAB_SCREENS/setting.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  late String fullName;
  late String id;
  @override
  void initState() {
    AuthTokenSave.getFullName().then((value) {
      setState(() {
        fullName = value ?? "na full name found";
      });
    });
    AuthTokenSave.getId().then((value) {
      setState(() {
        id = value ?? "na id found";
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "${fullName}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text("${id}"),
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
              
              Get.to(MyAccount(), arguments: {
                'id': Get.arguments[2],
                'name': "${Get.arguments[0]} ${Get.arguments[1]}",
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.app_registration_outlined),
            title: Text('Course Registration'),
            onTap: () {
              Get.to(RegisterCourse());
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
