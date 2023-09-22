import 'package:flutter/material.dart';

// 상단부 로고 글씨
class logo extends StatelessWidget {
  const logo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20,30,20,10),//좌,상,우,하  //여기 수정
      child: Text(
        'JellyBean',
        style: TextStyle(
          color: Colors.black,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
