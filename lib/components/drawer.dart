import 'package:flutter/material.dart';
import 'package:test/components/my_list_tile.dart';

// 페이지 네비바 컴포넌트
class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;
  final void Function()? onHomeTap;

  const MyDrawer({
    super.key,
    required this.onProfileTap,
    required this.onSignOut,
    required this.onHomeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 64,
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
