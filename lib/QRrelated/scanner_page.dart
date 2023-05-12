import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String qrCodeResult = "Not Yet Scanned";

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'QRID QR Code Scanner',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 25.0,
            ),
            // qr code image
        (qrCodeResult != "Not Yet Scanned") ? GestureDetector(child: Text("Got data"), onTap: () async{
            var url = Uri.parse("http://10.194.109.26:8000/instructor/attended");
            var resp = http.post(url, body: {
              'name': "yeab"
            });
            print('data sent');
             
           },):Text(''),
           
            const SizedBox(
              height: 25.0,
            ),
           
            GestureDetector(
              onLongPress: () {},
              child: SelectableText(
                qrCodeResult,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
                cursorColor: Colors.red,
                showCursor: true,
                toolbarOptions: const ToolbarOptions(
                  copy: true,
                  cut: true,
                  paste: true,
                  selectAll: true,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),


            Container(
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
              height: 68.0,
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
                onPressed: () async {
                  // write the post code here
                  ScanResult codeScanner = await BarcodeScanner.scan();
                  setState(
                    () {
                      qrCodeResult = codeScanner.rawContent;
                    },
                  ); //barcode scanner
                },
                child: const Text(
                  "Get atendance",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
               Container(
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
              height: 68.0,
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
                onPressed: () async {
                  // write the post code here
                  ScanResult codeScanner = await BarcodeScanner.scan();
                  setState(
                    () {
                      qrCodeResult = codeScanner.rawContent;
                    },
                  ); //barcode scanner
                },
                child: const Text(
                  "Register to course",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
