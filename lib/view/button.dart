import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
 final Function()? onTap;
   const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
        ),
    
        child: const Center(
          
          child: Text(
            "Sign in",style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),
    
          ),
        ),
      ),
    );
  }
}