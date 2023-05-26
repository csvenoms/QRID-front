import 'package:flutter/material.dart';

import '../utils/ChatWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WebView(
initialUrl: "http://10.194.109.12:8000/chat/message/2/",

    ));
  }
}
