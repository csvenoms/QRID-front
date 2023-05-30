// ignore_for_file: file_names
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../MODELS/Post.dart';
import '../utils/global.colors.dart';
import '../view/sharedPreference.dart';
import './Home.dart';
class Announcement {
  final int id;
  final String announcer;
  final String announcement;
  final DateTime announcementTime;

  Announcement({
    required this.id,
    required this.announcer,
    required this.announcement,
    required this.announcementTime,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      announcer: json['announcer'],
      announcement: json['announcement'],
      announcementTime: DateTime.parse(json['announcement_time']),
    );
  }
}

class SavedMessages {
  final String announcer;
    final String announcement;

  final String user;

  SavedMessages({
    required this.announcer,
    required this.announcement,
    required this.user,
  });

  factory SavedMessages.fromJson(Map<String, dynamic> json) {
    return SavedMessages(
      announcer: json['announcer'],
      user: json['user'],
      announcement: json['announcement']
    );
  }
}

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  late String email;
  @override
  void initState() {
    AuthTokenSave.getEmail().then((value) {
      setState(() {
        email = value ?? "na email found";
      });
    });
    super.initState();
  }

  // Future<List<SavedMessages>> getSaved() async {
  //   final response =
  //       await http.get(Uri.parse('${NetworkURL.URL}/getUserSaveAnnouncements/$email'));
  //   if (response.statusCode == 200) {
  //     List<dynamic> jsonMessages = json.decode(response.body);
  //     return jsonMessages.map((jsonMessages) => SavedMessages.fromJson(jsonMessages)).toList();
  //   } else {
  //     throw Exception('Failed to load messages');
  //   }
  // }
Future<List<SavedMessages>> _getAnnouncements() async {
    final response = await http
        .get(Uri.parse('${NetworkURL.URL}/getUserSaveAnnouncements/$email'));
    if (response.statusCode == 200) {
      List<dynamic> jsonAnnouncements = json.decode(response.body);
      return jsonAnnouncements
          .map((jsonAnnouncement) => SavedMessages.fromJson(jsonAnnouncement))
          .toList();
    } else {
      throw Exception('Failed to load announcements');
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
      color: GlobalColors.mainColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(15.0),
                child: FutureBuilder(
                  future: _getAnnouncements(),
                  builder: (context, snapshot) {
                    List<SavedMessages>? announcements = snapshot.data;
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: announcements?.length,
                        itemBuilder: (context, index) {
                          SavedMessages announcement = announcements![index];
                          return Container(
                              child: Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Image.asset(
                                      'assets/logo/wku-logo.png',
                                      width: 40.0,
                                      height: 40.0,
                                    ),
                                    Text(
                                      "${announcement.announcer} ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Image(
                                    image: NetworkImage(
                                        "${NetworkURL.URL}${announcement.announcement}")),
                              ),
                             
                            ],
                          ));
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Failed to load announcements'),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )),
          ],
        ),
      ),
    )
         
        
              );
  }
}
