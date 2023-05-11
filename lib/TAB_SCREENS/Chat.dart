import 'package:flutter/material.dart';

import '../utils/ChatWidget.dart';


class Chat extends StatefulWidget{

  const Chat({Key? key}) : super(key: key);
  @override
  State<Chat> createState()=>_ChatState(); 
 
  

}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
        body: ListView.separated(
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 10,
          itemBuilder: (context,index){
          return  ChatWidget();
        }, separatorBuilder: (context, index){
          return  Divider();
        }),

    ); 
  }
}