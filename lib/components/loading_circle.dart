import 'package:flutter/material.dart';

// 로딩 동그라미
class LoadingCircle extends StatelessWidget {
  const LoadingCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(),
    ));
  }
}
