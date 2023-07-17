//얘도 만들어라!
import 'package:flutter/material.dart';

class InquiryPage extends StatefulWidget {
  const InquiryPage({super.key});

  @override
  State<InquiryPage> createState() => _InquiryPageState();
}

class _InquiryPageState extends State<InquiryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JellyBean"),
        backgroundColor: Color.fromARGB(255,211,195,227),
        //Colors.grey[900],
      ),
    );
  }
}