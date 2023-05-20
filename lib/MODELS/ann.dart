import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Post.dart';

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

class AnnouncementsScreen extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcements'),
      ),
      body: FutureBuilder<List<Announcement>>(
        // Future that resolves to a list of announcements
        future: _getAnnouncements(),

        // Builder function that handles different states of the future
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Announcement> announcements = snapshot.data!;
            return ListView.builder(
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                Announcement announcement = announcements[index];
                
                return Container(
                  width: 200,
                  child: Column(
                    children: [
                      Container(
                        width: 180,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/logo/wku-logo.png',
                              height: 40,
                              width: 40,
                            ),
                            Text("${announcement.announcer}")
                          ],
                        ),
                        
                      ),
                      SizedBox(height: 8,),
                      Column(
                        children: [
                          Container(
                            width: 180,
                            child: Image(
                              image: NetworkImage('${NetworkURL.URL}/${announcement.announcement}')),
                          ),
                          Icon(Icons.bookmark_add)
                        ],
                      )
                    ],
                  ),
                );
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
      ),
    );
  }
}
