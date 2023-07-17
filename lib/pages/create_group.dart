import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/components/logo.dart';
import 'package:test/components/my_list_tile.dart';
import 'package:test/components/my_textfield.dart';
import 'package:test/pages/create_or_search.dart';
import 'package:test/pages/home_page.dart';
import 'package:test/components/my_button_group.dart';

import 'main_page.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final gNameController = TextEditingController();
  final MemberNumbController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection("Users");



  String docid = '';

  bool buttonState = false;
  

  // 그룹 생성후 데이터베이스에 입력 함수
  void createGroup() {
    if (gNameController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("Groups").add({
        'GroupName': gNameController.text,
        'UserEmail': currentUser.email,
        'Member': MemberNumbController.text,
      }).then(
        (DocumentReference doc) {
          docid = doc.id;
          print("${docid}");
          userCollection.doc(currentUser.email).update({
            'group id': FieldValue.arrayUnion([docid]),
          });
        },
      );
      // 그룹 데이터 베이스 Document uid 유저 데이터베이스 document에 항목 추가
      userCollection.doc(currentUser.email).update({
        'group id': docid,
      });
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
        builder: (context) => MainPage(),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //const SizedBox(
          //  height: 50,
          //),
          logo(),
          
          
          Column(
            children: [
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              Text(
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
                width: 140,
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
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: TextField(
                  controller: MemberNumbController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                ),
                width: 140,
              ),
            ],
          ),
            ]
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
          //SizedBox(
          //  height: 50,
          //),
          Padding(
            padding: const EdgeInsets.all(15.0),
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
                        MyButtonGroup(
                        text: "  생성하기  ", //버튼 안 글
                        onTap: createGroup,  //눌렀을 때 함수
                        ),
                      ],
                    ),
                    //height: 100,
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
