// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQrCodePage extends StatelessWidget {
  String id;
   GenerateQrCodePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'QR Code Generator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("Generated QR Code",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 250,
                  child: QrImage(
                    data: id,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Divider(
                height: 20.0,
                thickness: 1.0,
                color: Colors.black,
                endIndent: 42.0,
                indent: 42.0,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                height: 12.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
