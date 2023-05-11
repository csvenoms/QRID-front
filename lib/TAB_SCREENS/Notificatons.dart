import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/NotificationWidegt.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 12,
          itemBuilder: (context, index) {
            return NotificationWidegt();
          },
          separatorBuilder: (context, index) {
            return Divider();
          }),
    );
  }
}
