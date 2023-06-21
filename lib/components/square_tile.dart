import 'package:flutter/material.dart';

// 이미지 버튼 함수

class SquareTile extends StatelessWidget {
  final String ImagePath;
  final Function()? onTap;

  const SquareTile({
    super.key,
    required this.ImagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Image.asset(
          ImagePath,
          height: 40,
        ),
      ),
    );
  }
}
