import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/pages/create_or_search.dart';
import 'package:test/pages/inquiry_page.dart';
import 'package:test/pages/main_page.dart';
import 'package:test/pages/notice_page.dart';
import 'package:test/pages/profile_page.dart';
import 'package:test/services/auth_service.dart';
import 'package:test/services/group/get_group_id.dart';
import 'package:test/services/group/get_group_name.dart';

import '../components/drawer.dart';
import '../components/plus_button.dart';
import 'create_group.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({super.key});

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final userCollection = FirebaseFirestore.instance.collection("users");

  // 그룹 document IDs
  List<String> docIDs = [];

  // get docIDs
  Future getDocId() async {
    await userCollection.doc(currentUserId).collection('groups').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            docIDs.add(document.reference.id);
          }),
        );
  }

  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  void newGroup() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateOrSearchGroup(),
      ),
    );
  }

  void goToHomePage() {}

  void signUserOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

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
        builder: (context) => const InquiryPage(),
      ),
    );
  }

  @override
  void initState() {
    getDocId();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JellyBean"),
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
              onPressed: newGroup,
              icon: Icon(Icons.add_circle_outline))
        ],
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOut: signUserOut,
        onHomeTap: goToHomePage,
        onNoticeTap: goToNoticePage,// 여기 수정함
        onInquiryTap: goToInquiryPage,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: (docIDs.length - 1),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: GetGroupName(documentId: docIDs[index]),
                          tileColor: Colors.grey[300],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage(
                                        groupId: docIDs[index],
                                      )),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
