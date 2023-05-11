import 'package:flutter/material.dart';
import '../utils/NotificationWidegt.dart';

class NotificationP extends StatefulWidget{

  const NotificationP({Key? key}) : super(key: key);
  @override
  State<NotificationP> createState()=>_NotificationPState(); 
 
  

}

class _NotificationPState extends State<NotificationP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
        body: ListView.separated(
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 10,
          itemBuilder: (context,index){
          return  NotificationWidegt();
        }, separatorBuilder: (context, index){
          return  Divider();
        }),

    ); 
  }
}


