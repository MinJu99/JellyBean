import 'package:flutter/material.dart';
import 'package:test/components/drawer.dart';
import 'package:test/components/logo.dart';
import 'package:test/components/my_textfield.dart';
import 'package:test/pages/setting_page.dart';
import 'package:test/services/group/get_logo_name.dart';
import '../components/drawer.dart';
import 'package:test/pages/group_list_page.dart';
import 'package:test/pages/inquiry_page.dart';
import 'package:test/pages/notice_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  final String docID;
  const HomePage({
    required this.docID,
    super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  void goToGListPage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GroupListPage(),
      ),
    );
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
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

  void goToInquiryPage() {
    //Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InquiryPage(),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      endDrawer: MyDrawer(
        //Drawer->endDrawer
        onProfileTap: goToProfilePage,
        onSignOut: signOut,
        onHomeTap: goToGListPage,
        onNoticeTap: goToNoticePage,
        onInquiryTap: goToInquiryPage,
      ),
      body: Stack(
        alignment: Alignment.topRight, //버튼 우측
        children: [
          //_pages[_selectedIndex],
          Positioned(
            top: 40, //5
            left: 10,
            child: GetLogoName(documentId: widget.docID,)),
          Positioned(
            top: 70, //30
            right: 20,
            child: IconButton(
              //padding: const EdgeInsets.all(30),
              icon: Icon(Icons.menu),
              color: Colors.black,
              onPressed: () {
                _globalKey.currentState!
                    .openEndDrawer(); //openDrawer->openEndDrawer
              },
            ),
          ),
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 130,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 90, //유동적이게
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      //color: Colors.grey[300],
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300, //500
                            offset: const Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0),
                        /*const BoxShadow(
                            color: Colors.white,
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0),*/
                      ]),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '공 지 사 항',
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 15),
                        ),
                        Text(
                          '등록된 공지사항이 없습니다.',
                          style:
                              TextStyle(color: Colors.grey[800], fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40,),
                Row(
                  children: [
                    Container(
                      child: Image.asset(
                        'lib/images/app_icon.jpg',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 30,),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
