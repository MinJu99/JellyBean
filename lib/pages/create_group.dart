import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/components/logo.dart';
import 'package:test/components/my_button_group.dart';
import 'package:test/pages/create_or_search.dart';
import 'package:test/pages/group_list_page.dart';
import 'package:test/pages/share_and_move.dart';
import 'package:test/services/create_group_service.dart';
import 'dart:math';

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
  String gCode = "";

  bool buttonState = false;

  // 그룹 생성후 데이터베이스에 입력 함수
  void createGroupList(String groupId) async {
    if (gNameController.text.isNotEmpty) {
      await _groupService.createGroupList(groupId, gNameController.text, gCode);
    }
  }

  void createGroup() {
    if (gNameController.text.isNotEmpty) {
      gCode = _generateSecureCode();
      final doc = FirebaseFirestore.instance.collection("Groups").doc();

      FirebaseFirestore.instance.collection("Groups").doc(doc.id).set({
        'GroupName': gNameController.text,
        'CreatorEmail': currentUser.email,
        'Member': memberNumbController.text,
        'GroupCode': gCode,
      });
      
      createGroupList(doc.id);

      // 생성후 메인페이지로 이동
      goToMainPage(doc.id);
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
  void goToMainPage(String docId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShareAndMove(documentId: docId,),
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

  String _generateSecureCode() {
    String capLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String smallLetters = "abcdefghijklmnopqrstuvwxyz";
    String nums = "0123456789";

    String codeString = "$capLetters$smallLetters$nums";

    return List.generate(6, (index) {
      int randomIndex = Random.secure().nextInt(codeString.length);
      return codeString[randomIndex];
    }).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //const SizedBox(
          //  height: 50,
          //),
          const logo(),

          Column(children: [
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const Text(
                  '모임명',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  width: 45,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                  width: 180,
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
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const Text(
                  '최대인원',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  width: 24,
                ), //여기 수정
                Container(
                  margin: const EdgeInsets.all(8),
                  width: 180, //여기 수정
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
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 100,),
                Text(
                  '모임에 회비가 있나요?',
                  style: TextStyle(color: const Color.fromRGBO(97, 97, 97, 1)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 4,),
                GestureDetector(
                  onTap: () {
                    TextStyle(color: Colors.purple);
                  },
                  child: const Text(
                    'YES',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ]),
          //SizedBox(
          //  height: 50,
          //),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      iconSize: 30,
                      onPressed: goToChosenPage,
                    ),
                    Expanded(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MyButtonGroup(
                              //elavated button으로 변경
                              text:
                                  "생성하기",
                              onTap: createGroup, //눌렀을 때 함수
                            ),
                          ],
                        ),
                        //height: 100,
                      ),
                    )
                  ],
                ),
              ),
              //const SizedBox(height: 40,),
            ],
          ),
        ],
      ),
    );
  }
}