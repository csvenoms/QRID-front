// ignore_for_file: file_names, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../utils/global.colors.dart';

import '../DATA/Data.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalColors.mainColor,
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              height: 100,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: Colors.black,
                        size: 50,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "Write your comments!",
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20)),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  )
                ],
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.all(15.0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Data.dataList.length,
                itemBuilder: (context, index) => post(index: index),
              )),
        ],
      ),
    );
  }

  Widget post({required int index}) {
    return Data.dataList[index].isCreate
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            Data.dataList[index].imgPath,
                            width: 40,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Data.dataList[index].userName,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                Data.dataList[index].hour,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        Icons.more_horiz,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // ignore: avoid_unnecessary_containers
                Container(child: Image.asset(Data.dataList[index].postImage)),
                Container(
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.bookmark_outline_outlined,
                          color: Colors.black,
                          size: 40,
                        )
                      ],
                    ))
              ],
            ),
          );
  }
}
