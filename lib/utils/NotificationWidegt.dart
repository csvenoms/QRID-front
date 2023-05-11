import 'package:flutter/material.dart';

class NotificationWidegt extends StatelessWidget {
  const NotificationWidegt({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: 15,),
            Text("Earlier", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
          ],
        ),
        
        SizedBox(height: 5,),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/logo/wku-logo.png"),
          ),
          title: Text("New announcement for all students is here."),
          trailing: Icon(Icons.notifications_active),
          onTap: () => {},
        ),
      ],
    );
  }
}
