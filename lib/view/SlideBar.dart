// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/TAB_SCREENS/My_Account.dart';
import 'package:get/get.dart';
import '../TAB_SCREENS/CourseRegister.dart';

class SlideBar extends StatelessWidget {
  const SlideBar({super.key});
void getData(){

}
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
            accountEmail: null,
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
            title: Text('My Account'),
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
            // onTap: () =>null,
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Saved'),
            // onTap: () =>null,
          ),
          ListTile(
            leading: Icon(Icons.settings_applications),
            title: Text('Setting'),
            // onTap: () =>null,
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help & Support'),
            // onTap: () =>null,
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About Us'),
            // onTap: () =>null,
          ),
        ],
      ),
    );
  }
}
