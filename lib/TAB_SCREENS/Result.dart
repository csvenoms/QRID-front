// ignore_for_file: file_names

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/MODELS/Post.dart';
import 'package:flutter_application_1/view/sharedPreference.dart';
import '../utils/global.colors.dart';
import 'package:http/http.dart' as http;

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late String email;

  @override
  void initState() {
    AuthTokenSave.getEmail().then((value) {
      setState(() {
        email = value ?? "emaill not found";
      });
    });
    super.initState();
  }

  Future<Map<String, dynamic>> getResult() async {
    final response = await http
        .get(Uri.parse("${NetworkURL.URL}/registrar/getGrade/$email/"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> getCourses() async {
    final response = await http.get(
        Uri.parse("${NetworkURL.URL}/registrar/getSemisterCourses/$email/"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Result',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Space Age',
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: getResult(),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data found');
            } else {
              Map<String, dynamic> result = snapshot.data!;
              return ListView.builder(
                itemCount: result.length,
                itemBuilder: (BuildContext context, int index) {
                  String key = result.keys.elementAt(index);
                  dynamic value = result[key];
                  // return ListTile(
                  //   title: Text(key),
                  //   subtitle: Text(value.toString()),
                  // );
                  if (key == "email") {
                    return Text("");
                  }
                  return Center(
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(3.0)),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              "$key :",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              value.toString(),
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
