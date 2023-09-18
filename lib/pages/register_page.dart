import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:test/components/my_button.dart';
import 'package:test/components/my_textfield.dart';
import 'package:test/services/auth_service.dart';

import 'package:test/components/logo.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passedController = TextEditingController();
  final confimPasswordController = TextEditingController();
  final nameController = TextEditingController(); //추가함
  final birthController = TextEditingController();
  final phoneNumberController = TextEditingController();

  //sign user up method
  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    if (passedController.text != confimPasswordController.text) {
      Navigator.pop(context);
      showErrorMessage("아이디 혹은 비밀번호를 다시 확인해주세요");
    }
    //try creating the user
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passedController.text,
      );

      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'useremail': emailController.text.split('@')[0],
        'username': '',
        'bio': 'Emptybio',
        'group id': [],
      });

      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }
  }

  //error message
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //const SizedBox(height: 50),

              logo(), //왼쪽 위로 가야되는데 center로 설정해서 못함 이거 우째
              
              //welcome
              Text(
                '회원가입',
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              /*
              Text(
                '회원가입',
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              
              //create account
              Text(
                '당신의 계정을 만들어보세요!',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 15),
              */

            
              //username

              MyTextField(
                controller: emailController,
                hintText: 'ID(e-mail)',
                obscureText: false,
              ),

              //passwd

              MyTextField(
                controller: passedController,
                hintText: '비밀번호',
                obscureText: true,
              ),

              MyTextField(
                controller: confimPasswordController,
                hintText: '비밀번호 확인',
                obscureText: true,
              ),

              const SizedBox(height: 20),
              
              // 회원 정보

              MyTextField(
                controller: nameController,
                hintText: '이름',
                obscureText: false,
              ),

              MyTextField(
                controller: birthController,
                hintText: '생년월일',
                obscureText: false,
              ),

              MyTextField(
                controller: phoneNumberController,
                hintText: '전화번호',  //옆에 인증 버튼 만들기
                obscureText: false,
              ),

              /* 전화번호 인증 버튼 눌렀을 때 나오는 입력창?
              MyTextField(
                controller: confimPasswordController,
                hintText: '인증번호',
                obscureText: true,
              ),
              */

              /* 현재 아이디 == 이메일
              MyTextField(
                controller: confimPasswordController,
                hintText: '이메일',
                obscureText: true,
              ),
              */

              const SizedBox(height: 25),

              //sign in button
              
              MyButton(
                text: "회원가입",
                onTap: signUserUp,
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              //구글 로그인

              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '이미 계정을 가지고 계십니까?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      '로그인하기',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
