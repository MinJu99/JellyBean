import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/groups.dart';

class GroupService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createGroupList(String groupId, String groupName, String gCode) async {
    // 현재 사용자 정보 받아오기
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currenUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // 새로운 그룹 생성
    Groups newGroup = Groups(
      groupId: groupId,
      groupName: groupName,
      groupCode: gCode,
      timestamp: timestamp,
    );

    // 새로운 그룹 DB입력
    await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('groups')
        .doc(groupId)
        .set(newGroup.toMap());
  }

  //그룹리스트 출력
  Stream<QuerySnapshot> getGroup(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('groups')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
