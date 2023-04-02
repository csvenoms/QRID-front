import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/NotificationWidegt.dart';





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
          itemCount: 12,
          itemBuilder: (context,index){
          return  NotificationWidegt();
        }, separatorBuilder: (context, index){
          return  Divider();
        }),

    ); 
  }
}