import 'package:flutter/material.dart';

//버튼 위젯
//수정 필요 현재 my_button.dart 복붙

class MyButtonGroup extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyButtonGroup({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255,211,195,227),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20,
                                   fontWeight: FontWeight.bold), 
          ),
        ),
      ),
    );
  }
}
