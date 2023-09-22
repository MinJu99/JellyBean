// 만들어라!
import 'package:flutter/material.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JellyBean"),
        backgroundColor: const Color.fromARGB(255,211,195,227),
      ),
    );
  }
}