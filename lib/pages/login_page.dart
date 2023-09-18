import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:test/components/my_button.dart';
import 'package:test/components/my_textfield.dart';
import 'package:test/services/auth_service.dart';
import 'package:test/components/logo.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passedController = TextEditingController();

  //sign user in method
  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passedController.text,
      );
      Navigator.pop(context);
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
              const SizedBox(height: 20),
              logo(),
              
              /*Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'JellyBean',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              */


              ////logo
              //Icon(Icons.lock, size: 100, );
  
              //const SizedBox(height: 20),


              //welcomeback
              /*Text(
                '로그인',
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 25),
              */

              Text(
                '아이디와 비밀번호를 입력하여 로그인하세요!',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 15),



              /*Container(
                height: 130,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
              ),
              */


              
              //username
              MyTextField(
                controller: emailController,
                hintText: '이메일',
                obscureText: false,
              ),

              const SizedBox(
                height: 20,
              ),

              //passwd
              MyTextField(
                controller: passedController,
                hintText: '비밀번호',
                obscureText: true,
              ),

              const SizedBox(height: 15),

              Text(
                '아이디/비밀번호 찾기',
                style: TextStyle(color: Colors.grey[600]),
              ),

              const SizedBox(height: 25),

              //sign in button

              MyButton(
                text: "로그인",
                onTap: signUserIn,
              ),

              const SizedBox(height: 20),

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
                        '구글로 로그인 하기',
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
                    '회원이 아니세요?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      '회원가입 하기',
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
