import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'scanner_page.dart';
import 'generator_page.dart';

class QR extends StatefulWidget {
  const QR({Key? key}) : super(key: key);

  @override
  State<QR> createState() => _QRState();
}

class _QRState extends State<QR> {
  String id = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'QRID',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 16.0,
              ),
              Button(
                'Scan QR Code for attendance',
                const ScanPage(),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Button(
                'Get QR',
                const GenerateQrCodePage(),
              ),
              const SizedBox(
                height: 110.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Button(String text, Widget widget) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      height: 50.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.black,
              width: 1.0,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(
              32.0,
            ),
          ),
        ),
        onPressed: () {
          
          Get.to(widget,arguments: [id]);
        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
