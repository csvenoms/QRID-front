import 'package:flutter/material.dart';
import 'package:flutter_application_1/QRrelated/home_page.dart';
import 'package:get/get.dart';

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
            label: '',
          ),
          const BottomNavigationBarItem(icon: Icon(null), label: ''),
        ],
            onTap: (value) {
              Get.to(QR(), arguments: [Get.arguments[2]]);
            }));
  }
}
