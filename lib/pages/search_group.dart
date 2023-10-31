import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test/components/logo.dart';
import 'package:test/pages/add_newMem.dart';
import 'package:test/pages/create_or_search.dart';
import 'package:test/pages/main_page.dart';

class SearchGroup extends StatefulWidget {
  const SearchGroup({super.key});

  @override
  State<SearchGroup> createState() => _SearchGroupState();
}

class _SearchGroupState extends State<SearchGroup> {
  final GcodeController = TextEditingController();
  String gCode = '';

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
    String logoText = "JellyBean";
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          logo(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey.shade400,
                  ),
                ),
                child: const Icon(
                  Icons.search,
                  size: 40, //아이콘 사이즈 수정함
                  color: Color.fromARGB(255, 186, 158, 215), //색 수정함
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                margin: const EdgeInsets.all(8),
                width: 200,
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      gCode = val;
                    });
                  },
                  controller: GcodeController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      hintText: '코드 입력',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 20,
                      )),
                ),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Groups').snapshots(),
              builder: (context, snapshot) {
                return (snapshot.connectionState == ConnectionState.waiting)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                              
                              if (gCode.isEmpty) {}

                              if (data['GroupCode']
                                  .toString()
                                  .startsWith(gCode)) {
                                return ListTile(
                                  title: Text(data['GroupName']),
                                  onTap:() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewMember(
                                            documentId: data['id'],
                                            gCode: data['GroupCode'],
                                            gName: data['GroupName'],
                                          )),
                                );
                              },
                                );
                              }
                              return Container();
                            }),
                      );
              }),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  iconSize: 30,
                  onPressed: goToChosenPage,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
