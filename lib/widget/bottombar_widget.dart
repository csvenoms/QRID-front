import 'package:flutter/material.dart';

class BottombarWidget extends StatelessWidget {
  const BottombarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: BottomNavigationBar(
// ignore: prefer_const_literals_to_create_immutables
      items: [
        const BottomNavigationBarItem(icon: Icon(null), label: ''),
        const BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code_scanner_rounded,
              color: Colors.black,
              size: 35,
            ),
            label: ''),
        const BottomNavigationBarItem(icon: Icon(null), label: ''),
      ],
    ));
  }
}
