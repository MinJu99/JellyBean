import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/components/drawer.dart';
import 'package:test/components/my_textfield.dart';
import 'package:test/components/wall_post.dart';
import 'package:test/pages/profile_page.dart';
import 'package:test/pages/setting_page.dart';
import '../const.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  final textContoller = TextEditingController();
  final userCollection = FirebaseFirestore.instance.collection('Users');

  //navigate bottom bar

  int _selectedIndex = 0;
  // 하단 네비 바
  void navigationBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 메시지 전송 함수
  void postMessage() {
    //only post if ther is something in the textfield
    if (textContoller.text.isNotEmpty) {
      //store in firebase
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser.email,
        'Message': textContoller.text,
        'TimeStamp': Timestamp.now(),
      });
    }
    
    // 메시지 전송 박스 비우기
    setState(() {
      textContoller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          children: [
            //채팅 화면
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("User Posts")
                    .orderBy(
                      "TimeStamp",
                      descending: false,
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        //get the message
                        final post = snapshot.data!.docs[index];
                        return WallPost(
                          message: post['Message'],
                          user: post['UserEmail'],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error${snapshot.error}',
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            //채팅 보내기
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: textContoller,
                      hintText: '',
                      obscureText: false,
                    ),
                  ),
                  //전송 버튼
                  IconButton(
                    onPressed: postMessage,
                    icon: const Icon(Icons.arrow_circle_up),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
