// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import '../utils/global.colors.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'About Us',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Space Age',
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('assets/logo/wku-logo.png'),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Welcome to JEFORE. We are a team of passionate developers who aim to create the best apps for our collage. Our mission is to make the Learning and teaching process better through technology. JEFORE is an application that is built by students for students and teachers in the College of Computing and Informatics. This application use QR code to perform campus and college related activities.',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          ListTile(
            leading: Icon(Icons.location_city),
            title: Text('Our Address'),
            subtitle: Text('Wolkite University, Wolkite, Ethiopia'),
            onTap: () {
              // Open map with our address
            },
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email Us'),
            subtitle: Text('Jefore@gmail.com'),
            onTap: () {
              // Open email app with our email address
            },
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Call Us'),
            subtitle: Text('+251 947896366'),
            onTap: () {
              // Make phone call to our phone number
            },
          ),
        ],
      ),
    );
  }
}
