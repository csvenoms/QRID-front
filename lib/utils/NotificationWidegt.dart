// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class NotificationWidegt extends StatelessWidget {
  const NotificationWidegt({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('user.png'), fit: BoxFit.cover)),
      ),
      title: Text(
        'Hamnu',
        style: TextStyle(color: Colors.black),
      ),
      subtitle: Text(
        'My cutie pie',
        style: TextStyle(color: Color.fromARGB(255, 40, 39, 39)),
      ),
      onTap: () {},
      enabled: true,
    );
  }
}
