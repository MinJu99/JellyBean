import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetGroupName extends StatelessWidget {
  final String documentId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final userCollection = FirebaseFirestore.instance.collection("users");

  GetGroupName({required this.documentId, super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference group =
        userCollection.doc(currentUserId).collection('groups');

    return FutureBuilder<DocumentSnapshot>(
      future: group.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text('${data['group name']}');
        }
        return const Text('JellyBean');
      }),
    );
  }
}
