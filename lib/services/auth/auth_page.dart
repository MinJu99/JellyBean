import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test/pages/create_or_search.dart';
import '../../pages/login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //유저 아이디 생성 후 로그인시
          if (snapshot.hasData) {
            return const CreateOrSearchGroup();
          }

          //로그인되지 않았을 시, 회원가입페이지
          else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
