import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:test/pages/group_list_page.dart';
import 'package:test/pages/profile_page.dart';
import 'package:test/services/auth_service.dart';
import 'package:test/services/group/get_group_name.dart';

import '../components/drawer.dart';
import 'calender_page.dart';
import 'chat_page.dart';
import 'deposit_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  final String groupId;

  MainPage({
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
      HomePage(),
      Chat(receiverUserID: widget.groupId,),
      CalendarPage(),
      DepositPage(),
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

  void goToHomePage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupListPage(),
      ),
    );
  }

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  void initState() {
    getPages();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetGroupName(documentId: widget.groupId),
        backgroundColor: Colors.grey[900],
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOut: signOut,
        onHomeTap: goToHomePage,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
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
