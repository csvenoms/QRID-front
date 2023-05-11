import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the new page when the ListTile is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatDetailsScreen()),
        );
      },
      child: ListTile(
        leading: Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logo/wku-logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          'Hamnu',
          style: TextStyle(color: Colors.black),
        ),
        subtitle: Text(
          'My cutie pie',
          style: TextStyle(color: Color.fromARGB(255, 40, 39, 39)),
        ),
        enabled: true,
      ),
    );
  }
}

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        titleSpacing: 0.0, 
        title: Row(
          children: [
            SizedBox(
              width: kToolbarHeight, 
              height: kToolbarHeight, 
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/logo/wku-logo.png'),
              ),
            ),
            SizedBox(width: 8.0), // add some spacing between avatar and title
            Text('Hamnu'),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true, // reverse the list view to show latest messages at the bottom
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ChatMessageWidget(
                  message: 'Message $index',
                  isMe: index % 2 == 0,
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {},
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatMessageWidget({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Text(
            message,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}