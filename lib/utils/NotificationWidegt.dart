
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
              const SizedBox(
                width: 15,
              ),
              const Text(
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
              const SizedBox(
                width: 15,
              ),
              const Text(
                "Older",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        const SizedBox(
          height: 5,
        ),
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage("assets/logo/wku-logo.png"),
          ),
          title: const Text(
            "New announcement for all students is here.",
          ),
          trailing: const Icon(Icons.notifications_active),
          onTap: () => {},
        ),
      ],
    );
  }
}