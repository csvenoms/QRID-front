import 'package:flutter/material.dart';

class Passfield extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final contrller;
final String hint;
final bool obscureText;
  const Passfield({
    super.key, 
    this.contrller,
     required this.hint,
      required this.obscureText
  
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  obscureText: true,
                  controller: contrller,
                  
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),

                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade400),

                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true,
labelText: "password"
                          ),

                ),
              );
  }
}


class MyTextField extends StatelessWidget {
// ignore: prefer_typing_uninitialized_variables
final contrller;
final String hint;
final bool obscureText;
  const MyTextField({
    super.key, 
    this.contrller,
     required this.hint,
      required this.obscureText
  
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  obscureText: false,
                  controller: contrller,
                  
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),

                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade400),

                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true,
labelText: "Username"
                          ),

                ),
              );
  }
}

class Logp extends StatelessWidget {
  const Logp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}