import 'package:cloud_firestore/cloud_firestore.dart';

class Groups {
  final String groupId;
  final String groupName;
  final String groupCode;
  final Timestamp timestamp;

  Groups({
    required this.groupId,
    required this.groupName,
    required this.timestamp,
    required this.groupCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'groupId': groupId,
      'group name': groupName,
      'group code': groupCode,
      'timestamp': timestamp,
    };
  }
}
