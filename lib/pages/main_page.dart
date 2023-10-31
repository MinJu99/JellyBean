import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:test/services/group/get_group_name.dart';
import '../components/drawer.dart';
import 'package:test/pages/testCalendar.dart';
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

  void groupName() {
    GroupName = GetGroupName(documentId: widget.groupId).toString();
  }

  String GroupName = "";

  List<Widget> _pages = [];

  Future getPages() async {
    _pages = [
      HomePage(docID: widget.groupId,),
      Chat(
        receiverUserID: widget.groupId,
      ),
      CalendarPage(
        groupId: widget.groupId,
      ),
      DepositPage(
        docId: widget.groupId,
      ),
    ];
  }

  @override
  void initState() {
    getPages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*여기는 혹시몰라 남겨둔 앱바...(아련)
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

      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.white, //const Color.fromARGB(255,211,195,227),
        child: Padding(
          //padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),  //원본
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 40),
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
