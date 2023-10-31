import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetLogoName extends StatelessWidget {
  final String documentId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final userCollection = FirebaseFirestore.instance.collection("users");

  GetLogoName({required this.documentId, super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference group =
        userCollection.doc(currentUserId).collection('groups');

    String groupName = "JellyBean";

    return FutureBuilder<DocumentSnapshot>(
      future: group.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          groupName = data['group name'];
          return Padding(
      padding: EdgeInsets.fromLTRB(20,30,20,10),//좌,상,우,하  //여기 수정
      child: Text(
        groupName,
        style: TextStyle(
          color: Colors.black,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
        }
        return Padding(
      padding: EdgeInsets.fromLTRB(20,30,20,10),//좌,상,우,하  //여기 수정
      child: Text(
        'JellyBean',
        style: TextStyle(
          color: Colors.black,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );;
      }),
    );
  }
}
