// import 'dart:async';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class ChatService {
//   IO.Socket socket;

//   StreamController<List<Message>> _messageStreamController =
//       StreamController<List<Message>>.broadcast();

//   Stream<List<Message>> get messageStream =>
//       _messageStreamController.stream;

//   void connect() {
//     socket = IO.io('http://localhost:3000', <String, dynamic>{
//       'transports': ['websocket'],
//     });

//     socket.on('connect', (_) {
//       print('connected to server');
//     });

//     socket.on('message', (data) {
//       List<Message> messages = data.map<Message>((json) => Message.fromJson(json)).toList();
//       _messageStreamController.add(messages);
//     });
//   }

//   void disconnect() {
//     socket.disconnect();
//     _messageStreamController.close();
//   }
// }