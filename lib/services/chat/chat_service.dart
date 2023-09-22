import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String groupID, String message) async {
    // 현재 사용자 정보 받아오기
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currenUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    Map<String, dynamic> currentUserInfo = <String, dynamic>{};
    await _firestore.collection('users').doc(currentUserId).get().then((value) {
      currentUserInfo = value.data()!;
    });

    String name = currentUserInfo['username'];

    // 새로운 메세지 입력
    Message newMessage = Message(
      senderId: currentUserId,
      senderName: name,
      senderEmail: currenUserEmail,
      receiverId: groupID,
      timestamp: timestamp,
      message: message,
    );


    // 새로운 메세지 DB입력
    await _firestore
        .collection('Groups')
        .doc(groupID)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //메세지 출력
  Stream<QuerySnapshot> getMessages(String groupId) {
    String chatRoomId = groupId;

    return _firestore
        .collection('Groups')
        .doc(groupId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
