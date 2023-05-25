// ignore_for_file: file_names, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../MODELS/Post.dart';
import '../utils/global.colors.dart';
import 'package:http/http.dart' as http;
import '../DATA/Data.dart';

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

class Home extends StatelessWidget {
  const Home({super.key});

  Future<List<Announcement>> _getAnnouncements() async {
    final response = await http
        .get(Uri.parse('${NetworkURL.URL}/registrar/getAnnouncementAPI'));
    if (response.statusCode == 200) {
      List<dynamic> jsonAnnouncements = json.decode(response.body);
      return jsonAnnouncements
          .map((jsonAnnouncement) => Announcement.fromJson(jsonAnnouncement))
          .toList();
    } else {
      throw Exception('Failed to load announcements');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalColors.mainColor,
      child: Column(
        children: [
         
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              height: 100,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "Write your comments!",
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20)),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  )
                ],
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.all(15.0),
              child: FutureBuilder(
                future: _getAnnouncements(),
                builder: (context, snapshot) {
                  List<Announcement>? announcements = snapshot.data;
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: announcements?.length,
                      itemBuilder: (context, index) {
                        Announcement announcement = announcements![index];
                        return  Container(
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
                            Container(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 300,
                                  ),
                                  GestureDetector(
                                      child: Icon(Icons.book),
                                      onTap: () async {
                                        try {
                                          var response = await http.post(
                                              Uri.parse(
                                                  "${NetworkURL.URL}/getUserAnnouncements"),
                                              body: {
                                                "announcement_id":
                                                    "${announcement.id}",
                                                "user": "${Get.arguments[3]}",
                                              });
                                          if (response.statusCode == 201) {
                                            Get.snackbar(
                                                "Success", "save announcement",
                                                colorText: Colors.white,
                                                backgroundColor: Colors.green,
                                                icon: Icon(Icons
                                                    .bookmark_added_outlined));
                                          }
                                        } catch (e) {
                                          Get.dialog(AlertDialog(
                                            content: Text("${e}"),
                                          ));
                                        }
                                      })
                                ],
                              ),
                            )
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
    );
  }
}
