import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:test/pages/group_list.dart';
import 'package:test/pages/profile_page.dart';

import '../components/drawer.dart';
import 'calender_page.dart';
import 'chatting_page.dart';
import 'deposit_page.dart';
import 'home_page.dart';
//추가
import 'notice_page.dart';
import 'inquiry_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

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

  final List<Widget> _pages = [
    HomePage(),
    ChatPage(),
    CalendarPage(),
    DepositPage(),
  ];

  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  void goToHomePage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupList(),
      ),
    );
  }

  void signUserOut() {
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
        builder: (context) => const NoticePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JellyBean"),
        backgroundColor: Color.fromARGB(255,211,195,227),
      ),
      drawer: Container(width: 250,
        child: MyDrawer(
          onProfileTap: goToProfilePage,
          onSignOut: signUserOut,
          onHomeTap: goToHomePage,
          onNoticeTap: goToNoticePage,// 여기 수정함
          onInquiryTap: goToInquiryPage,
        ),
      ),
      body: _pages[_selectedIndex],

      ///
      /// 여기 하단바
      bottomNavigationBar: Container(
        color: Color.fromARGB(255,211,195,227), //Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),  //가로 세로
          child: GNav(
            backgroundColor: Color.fromARGB(255,211,195,227),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Color.fromARGB(255, 184, 138, 230),  //눌렀을 때 색
            gap: 3,                                      //8->3로 변경 //하단바 눌렀을 때 색 변하는 범위
            onTabChange: _navigateBottomBar,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.home,
                text: '홈',
              ),
              GButton(
                icon: Icons.chat_bubble,
                text: '채팅',
              ),
              GButton(
                icon: Icons.calendar_month,
                text: '일정',
              ),
              GButton(
                icon: Icons.wallet,
                text: '정산하기',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
