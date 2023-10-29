import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:test/components/logo.dart';
import 'package:test/pages/group_list_page.dart';
import 'package:test/pages/inquiry_page.dart';
import 'package:test/pages/notice_page.dart';
import 'package:test/pages/profile_page.dart';
import 'package:test/screens/event_screen.dart';
import 'package:test/services/group/get_group_name.dart';

import '../components/drawer.dart';
import 'chat_page.dart';
import 'deposit_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  final String groupId;

  const MainPage({
    super.key,
    required this.groupId,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pages = [];

  Future getPages() async {
    _pages = [
      const HomePage(),
      Chat(receiverUserID: widget.groupId,),
      const EventScreen(),
      const DepositPage(),
    ];
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
        builder: (context) => const InquiryPage(),
      ),
    );
  }

  @override
  void initState() {
    getPages();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      endDrawer: MyDrawer(  //Drawer->endDrawer
          onProfileTap: goToProfilePage,
          onSignOut: signOut,
          onHomeTap: goToGListPage,
          onNoticeTap: goToNoticePage,
          onInquiryTap: goToInquiryPage,
      ),
      body: 
      Stack(
        alignment: Alignment.topRight, //버튼 우측
        children: [
          _pages[_selectedIndex],
          Positioned(
            top: 5,
            left: 10,
            child: logo(),
            ),
          Positioned(
            top: 30,
            right:20,
            child: IconButton(
              //padding: const EdgeInsets.all(30),
              icon: Icon(Icons.menu), 
              color: Colors.black,
              onPressed: () { 
                _globalKey.currentState!.openEndDrawer();//openDrawer->openEndDrawer
              },
            ),
          ),
        ],
      ),
      
      /* 여기는 혹시몰라 남겨둔 앱바...(아련)
      appBar: AppBar(
        title: GetGroupName(documentId: widget.groupId),
        backgroundColor: const Color.fromARGB(255,211,195,227),
      ),
      endDrawer: SizedBox(width: 250,
        child: MyDrawer(
          onProfileTap: goToProfilePage,
          onSignOut: signOut,
          onHomeTap: goToGListPage,
          onNoticeTap: goToNoticePage,// 여기 수정함
          onInquiryTap: goToInquiryPage,
        ),
      ),*/
      //body: _pages[_selectedIndex], 
      
      bottomNavigationBar: Container(
        
        color: Colors.white, //const Color.fromARGB(255,211,195,227),
        child: Padding(
          //padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),  //원본
          padding: const EdgeInsets.fromLTRB(15,5,15,40),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.grey[400],
            activeColor: const Color.fromARGB(255, 186, 158, 215),
            //tabBackgroundColor: const Color.fromARGB(255, 186, 158, 215),  //눌렀을 때 색
            //gap: 3, //하단바 눌렀을 때 색 변하는 범위
            onTabChange: _navigateBottomBar,
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: ' 홈',
              ),
              GButton(
                icon: Icons.chat_outlined,
                text: ' 채팅',
              ),
              GButton(
                icon: Icons.calendar_month,
                text: ' 일정',
              ),
              GButton(
                icon: Icons.wallet,
                text: ' 정산',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
