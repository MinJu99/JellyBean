import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/pages/main_page.dart';
import 'package:test/pages/profile_page.dart';

import '../components/drawer.dart';
import 'create_or_search.dart';
//추가
import 'notice_page.dart';
import 'inquiry_page.dart';

class GroupList extends StatefulWidget {
  GroupList({
    super.key,
  });

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection("Users");
  List gname = [];

  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  void goToHomePage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupList(),
      ),
    );
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void goToMainPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
    );
  }
  
  // 추가함
  void goToNoticePage() {
    //Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NoticePage(),
      ),
    );
  }
  // 추가함
  void goToInquiryPage() {
    //Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NoticePage(),
      ),
    );
  }

  void hasData() {
    DocumentReference data = userCollection.doc(currentUser.email);
    data.get().then((DocumentSnapshot doc) {
      final group = doc.data() as Map<String, dynamic>;
      List<String> len = List<String>.from(group['group id']);
      if (len.length.toInt() > 0) {
        print(len.length);
        return true;
      } else {
        return CreateOrSearchGroup();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JellyBean"),
        backgroundColor: Color.fromARGB(255,211,195,227), //Colors.grey[900],
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOut: signUserOut,
        onHomeTap: goToHomePage,
        onNoticeTap: goToNoticePage,// 여기 수정함
        onInquiryTap: goToInquiryPage,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            String tmp;
            for (int i = 0; i < 1; i++) {
              tmp = userData['group id'][i];
              gname.add(tmp);
              print(tmp);
            }

            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.only(top: 25, left: 25, right: 25),
                  padding: EdgeInsets.all(25),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                              onPressed: goToMainPage,
                              child: Text(
                                gname[index],
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
