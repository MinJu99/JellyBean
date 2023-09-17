import 'package:cloud_firestore/cloud_firestore.dart';

class Groups {
  final String groupId;
  final String groupName;
  final Timestamp timestamp;

  Groups({
    required this.groupId,
    required this.groupName,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'groupId': groupId,
      'group name': groupName,
      'timestamp': timestamp,
    };
  }
}
