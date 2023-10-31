import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:test/pages/group_list_page.dart';

class ShareAndMove extends StatefulWidget {
  const ShareAndMove({
    super.key,
    required this.documentId,
  });

  final String documentId;

  @override
  State<ShareAndMove> createState() => _ShareAndMoveState();
}

class _ShareAndMoveState extends State<ShareAndMove> {
  String test = 'text';

  void goToListPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GroupListPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(20),),
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Groups")
                .doc(widget.documentId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var groupData = snapshot.data!.data() as Map<String, dynamic>;
                return SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(groupData['GroupCode']),
                          SizedBox(height: 15,),
                          Row(children: [
                            shareButton('복사하기', () {
                              Share.share(groupData['GroupCode']);
                            },),
                            SizedBox(width: 15,),
                            OutlinedButton(
                                onPressed: goToListPage,
                                child: Text('그룹페이지로 이동',),
                            ),
                          ]),
                          //SizedBox(height: 40,),
                        ],
                      )),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error${snapshot.error}'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),),
      )
      
    );
  }

  void sharePressed() {
    Share.share(test);
  }

  shareButton(String title, Function()? onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}