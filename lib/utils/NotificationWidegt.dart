
import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    Key? key,
    required this.isEarlier,
    required this.index,
  }) : super(key: key);

  final bool isEarlier;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (isEarlier && index == 0) // Show the "Earlier" header for the first notification item
          Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Text(
                "Earlier",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        if (!isEarlier && index % 2 == 1 && index == 1) // Show the "Older" header for the first older notification item
          Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Text(
                "Older",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        SizedBox(
          height: 5,
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/logo/wku-logo.png"),
          ),
          title: Text(
            "New announcement for all students is here.",
          ),
          trailing: Icon(Icons.notifications_active),
          onTap: () => {},
        ),
      ],
    );
  }
}