// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../utils/global.colors.dart';

class Saved extends StatelessWidget {
  const Saved({super.key});

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
          'Saved',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Space Age',
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
