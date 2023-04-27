// ignore: unused_import
// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'home.view.dart';
import 'package:http/http.dart' as http;
import '../utils/global.colors.dart';
import 'button.dart';
import 'my_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //sign users in method

  Future<void> signUserIn() async {
    var url = Uri.parse('http://10.194.109.25:8000/api-token-auth/');
    var response = await http.post(url, body: {
      'username': usernameController.text,
      'password': passwordController.text,
    });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var token = jsonResponse['token'];

      if (jsonResponse['roll']!='Student'){
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsonResponse['roll']+" is not implimented on mobile yet!"),
        ),
      );
      }
      else{
        Navigator.push(context, MaterialPageRoute(
        builder: (context) => const HomePage(),
      )
      );
      }
     
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid username or password'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalColors.mainColor,
        body: SingleChildScrollView(
            child: SafeArea(
                child: Center(
                    child: Column(
                        // ignore: sized_box_for_whitespace
                        children: [
              Container(
                  padding: const EdgeInsets.all(35.0),
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/logo/wku-logo.png')),

              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 48,
                  fontFamily: 'Space Age',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                contrller: usernameController,
                hint: "Username",
                obscureText: false,
              ),
              const SizedBox(height: 20),
              Passfield(
                hint: "password",
                obscureText: true,
                contrller: passwordController,
              ),
              //signin button
              const SizedBox(height: 20),

              const Padding(
                padding: EdgeInsets.only(left: 170, bottom: 20),
                child: Text(
                  "Forgot password?",
                ),
              ),

              MyButton(
                onTap: signUserIn,
              ),
            ])))));
  }
}