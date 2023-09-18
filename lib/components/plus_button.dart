import 'package:flutter/material.dart';

// 정산 페이지 추가 버튼

class PlusButton extends StatelessWidget {
  final function;
  const PlusButton({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 214, 201, 227), //Color.fromARGB(255,211,195,227)
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '+',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
