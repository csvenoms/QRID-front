import 'dart:async';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../MODELS/Post.dart';
import '../view/sharedPreference.dart';

class Message {
  final String name;
  final String email;
  final String dept;
  final String batch;
  final String message;
  final String file;

  Message({
    required this.name,
    required this.email,
    required this.dept,
    required this.batch,
    required this.message,
    required this.file,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      name: json['name'],
      email: json['email'],
      dept: json['dept'],
      batch: json['batch'],
      message: json['message'],
      file: json['file'],
    );
  }
}

class MessageService {
  Future<List<Message>> getMessages() async {
    final response = await http.get(
        Uri.parse("${NetworkURL.URL}/message/getMessageAPI/fayaw456@csv.com"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      final List<Message> messages =
          jsonData.map((json) => Message.fromJson(json)).toList();
      return messages;
    } else {
      throw Exception('Failed to load messages');
    }
  }
}

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final MessageService messageService = MessageService();
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    // Timer.periodic(Duration(seconds: 15), (Timer timer) {
    _fetchMessages();
    // });
  }

  Future<List<Message>> _fetchMessages() async {
    try {
      List<Message> messages = await messageService.getMessages();
      Get.snackbar("message", "gjkjhg",
          backgroundColor: Colors.green);
      return messages;
    } catch (e) {
      print('Error: $e');
      return <Message>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Message>>(
        future: _fetchMessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Message> messages = snapshot.data!;
              return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Center(child: Text("${messages[index].message}"));
                },
              );
            } else {
              return Center(child: Text('No messages found.'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
