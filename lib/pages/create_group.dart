import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/components/logo.dart';
import 'package:test/components/my_list_tile.dart';
import 'package:test/components/my_textfield.dart';
import 'package:test/pages/create_or_search.dart';
import 'package:test/pages/group_list_page.dart';
import 'package:test/pages/home_page.dart';
import 'package:test/services/create_group_service.dart';

import 'main_page.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final gNameController = TextEditingController();
  final memberNumbController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final userCollection = FirebaseFirestore.instance.collection("users");
  final GroupService _groupService = GroupService();

  bool buttonState = false;

  // 그룹 생성후 데이터베이스에 입력 함수
  void createGroupList(String groupId) async {
    if (gNameController.text.isNotEmpty) {
      await _groupService.createGroupList(groupId, gNameController.text);
    }
  }

  void createGroup() {
    if (gNameController.text.isNotEmpty) {
      String gName = gNameController.text;
      final doc = FirebaseFirestore.instance.collection("Groups").doc();

      FirebaseFirestore.instance.collection("Groups").doc(doc.id).set({
        'GroupName': gNameController.text,
        'CreatorEmail': currentUser.email,
        'Member': memberNumbController.text,
      });

      createGroupList(doc.id);

      // 생성후 메인페이지로 이동
      goToMainPage();
    } else {
      showErrorMessage("그룹명은 최소 한글자 이상이어야 합니다.");
    }

    setState(() {
      gNameController.clear();
    });
  }

  //에러 메시지 표시
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  //메인페이지 이동 함수
  void goToMainPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupListPage(),
      ),
    );
  }

  // 모임 생성, 찾기 페이지 이동
  void goToChosenPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateOrSearchGroup(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          logo(),
          const SizedBox(
            height: 200,
          ),
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              Text(
                '모임명',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                ),
              ),
              const SizedBox(
                width: 55,
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: TextField(
                  controller: gNameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                ),
                width: 200,
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              Text(
                '최대인원',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: TextField(
                  controller: memberNumbController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                ),
                width: 200,
              ),
            ],
          ),
          /*Row(
            children: [
              Text(
                '모임에 회비가 있나요?',
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(
                width: 4,
              ),
              GestureDetector(
                onTap: () {
                  TextStyle(color: Colors.blue);
                },
                child: const Text(
                  '예',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),*/
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 30,
                  onPressed: goToChosenPage,
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          onPressed: createGroup,
                          child: const Text("생성하기"),
                        )
                      ],
                    ),
                    height: 100,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
