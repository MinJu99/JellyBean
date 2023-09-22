import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test/components/chat_bubble.dart';
import 'package:test/components/my_textfield.dart';
import 'package:test/services/chat/chat_service.dart';

class Chat extends StatefulWidget {
  final String receiverUserID;
  const Chat({
    super.key,
    required this.receiverUserID,
  });

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),

          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverUserID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('불러오는중..');
        }

        return ListView(
          children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid) ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Text(data['senderName']),
            const SizedBox(height: 5),
            ChatBubble(message: data['message']),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: '메세지를 입력하세요',
              obscureText: false,
            ),
          ),
          IconButton(
              onPressed: sendMessage,
              icon: Icon(
                Icons.arrow_upward,
                size: 40,
              ))
        ],
      ),
    );
  }
}