import 'package:flutter/material.dart';

// 입력값 작성 필드 함수

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: const TextStyle(fontSize: 13), //추가
        
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          //enabledBorder: OutlineInputBorder(
          //  borderSide: BorderSide(color: Colors.grey.shade700),
          //),
          //focusedBorder: OutlineInputBorder(
          //  borderSide: BorderSide(color: Colors.grey.shade400),
          //),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
