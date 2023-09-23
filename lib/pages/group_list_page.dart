import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/pages/create_or_search.dart';
import 'package:test/pages/inquiry_page.dart';
import 'package:test/pages/main_page.dart';
import 'package:test/pages/notice_page.dart';
import 'package:test/pages/profile_page.dart';
import 'package:test/services/auth_service.dart';
import 'package:test/services/group/get_group_name.dart';

import '../components/drawer.dart';

///앱 바 백그라운드 컬러 수정
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
        builder: (context) => const CreateOrSearchGroup(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JellyBean"),
        backgroundColor: const Color.fromARGB(255,211,195,227),
        actions: [
          IconButton(
              onPressed: newGroup,
              icon: const Icon(Icons.add_circle_outline))
        ],
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOut: signUserOut,
        onHomeTap: goToHomePage,
        onNoticeTap: goToNoticePage,
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
                        padding: EdgeInsets.fromLTRB(20,20,20,0),  //여기 수정
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200],
                            ),
                          child: ListTile(
                            title: GetGroupName(documentId: docIDs[index]),
                            textColor: Colors.black,
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
