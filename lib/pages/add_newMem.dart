import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:test/pages/group_list_page.dart';
import 'package:test/pages/main_page.dart';
import 'package:test/pages/search_group.dart';
import 'package:test/services/create_group_service.dart';

class NewMember extends StatefulWidget {
  const NewMember({
    super.key,
    required this.documentId,
    required this.gCode,
    required this.gName,
  });

  final String documentId;
  final String gName;
  final String gCode;

  @override
  State<NewMember> createState() => _NewMemberState();
}

class _NewMemberState extends State<NewMember> {
  String test = 'text';
  final GroupService _groupService = GroupService();

  void goToSearchPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchGroup(),
      ),
    );
  }

  void goToMainPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(
          groupId: widget.documentId,
        ),
      ),
    );
  }

  void createGroupList(String groupId, String gName, String gCode) async {
    await _groupService.createGroupList(groupId, gName, gCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(children: [
            Text('가입하시겠습니까?'),
            SizedBox(
              height: 15,
            ),
            OutlinedButton(
              onPressed: goToSearchPage,
              child: Text(
                '그룹 검색으로 이동',
              ),
            ),
            SizedBox(
              width: 15,
            ),
            OutlinedButton(
              onPressed: () {
                createGroupList(widget.documentId, widget.gName, widget.gCode);
                goToMainPage();
              },
              child: Text(
                '가입하기',
              ),
            ),
          ]),
          //SizedBox(height: 40,),
        )),
      )),
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
