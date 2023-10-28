import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final String title;
  final String date;

  Event({
    required this.id,
    required this.title,
    required this.date,
  });

  factory Event.fromJson(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Event(
      id: doc.id,
      title: data['title'],
      date: data['date'].toDate(), //따라하면 오류나서 다른거 참고/원본
    );
  }
}