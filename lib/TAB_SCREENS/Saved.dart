// ignore_for_file: file_names
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../MODELS/Post.dart';
import '../utils/global.colors.dart';
import './Home.dart';

class SavedMessages {
  final int id;
  final String user;

  SavedMessages({
    required this.id,
    required this.user,
  });

  factory SavedMessages.fromJson(Map<String, dynamic> json) {
    return SavedMessages(
      id: json['id'],
      user: json['user'],
    );
  }
}

class Saved extends StatelessWidget {
  const Saved({super.key});
  Future<List<SavedMessages>> getSaved() async {
    final response =
        await http.get(Uri.parse('${NetworkURL.URL}/getUserAnnouncements'));
    if (response.statusCode == 200) {
      List<dynamic> jsonMessages = json.decode(response.body);
      return jsonMessages
          .map((jsonMessages) => SavedMessages.fromJson(jsonMessages))
          .toList();
          
    } else {
      throw Exception('Failed to load messages');
    }
  }

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
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: getSaved(),
            builder: (context, snapshot) {
              List<SavedMessages>? messages = snapshot.data;
              if (snapshot.hasData) {
                return ListView.builder(itemBuilder: (context, index) {
                  SavedMessages message = messages![index];
                  return Container(
                    height: 300,
                    width: 300,
                    child: GestureDetector(
                      onTap: () {
//
                      },
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(
                            width: 8,
                          ),
                          Text("${message.id}")
                        ],
                      ),
                    ),
                  );
                });
              }
              return Text("No saved messages yet");
            },
          ),
        ));
  }
}
