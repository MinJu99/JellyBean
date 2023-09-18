import 'package:flutter/material.dart';
import 'package:test/components/my_list_tile.dart';

// 페이지 네비바 컴포넌트
class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;
  final void Function()? onHomeTap;
  final void Function()? onNoticeTap;  //추가
  final void Function()? onInquiryTap; //추가

  const MyDrawer({
    super.key,
    required this.onProfileTap,
    required this.onSignOut,
    required this.onHomeTap,
    required this.onNoticeTap,
    required this.onInquiryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                child: Icon(
                  Icons.person,
                  color: Color.fromARGB(255,211,195,227),
                  size: 60,
                ),
              ),
              // 홈 화면으로 이동
              MyListTile(
                icon: Icons.home,
                text: 'H O M E',
                onTap: onHomeTap,
              ),
              //프로필 화면 이동
              MyListTile(
                icon: Icons.person,
                text: 'P R O F I L E',
                onTap: onProfileTap,
              ),
              //공지  
              //관리자가 입력한 공지사항으로 이동
              MyListTile(
                icon: Icons.notifications_none,
                text: 'N O T I C E',
                onTap: onNoticeTap,
              ),
              //문의하기
              //관리자에게 문의하는 창으로 이동
              MyListTile(
                icon: Icons.chat,
                text: 'I N Q U I R Y',
                onTap: onInquiryTap,
              ),
            ],
          ),
          // 로그아웃 버튼
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
              icon: Icons.logout,
              text: 'L O G O U T',
              onTap: onSignOut,
            ),
          ),
        ],
      ),
    );
  }
}
