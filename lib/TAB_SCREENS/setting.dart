// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore

import 'package:flutter/material.dart';
import '../utils/global.colors.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
          'Setting',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontFamily: 'Space Age',
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 40),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Icon(
                  Icons.person,
                  size: 35,
                ),
                SizedBox(width: 10),
                Text(
                  "Account",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(height: 20, thickness: 2),
            SizedBox(height: 10),
            buildAccountOption(context, "Change Password"),
            buildAccountOption(context, "Privacy and Security"),
            SizedBox(height: 40),
            Row(
              children: [
                Icon(
                  Icons.ac_unit,
                  size: 35,
                ),
                SizedBox(width: 10),
                Text(
                  "Appearance",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(height: 20, thickness: 2),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  Padding buildNoticationOption(
      String title, bool value, Function onChangeMethod) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    );
  }

  GestureDetector buildAccountOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              )),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          )
        ]),
      ),
    );
  }
}