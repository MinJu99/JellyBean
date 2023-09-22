import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/components/logo.dart';
import 'package:test/components/my_button.dart';
import 'package:test/services/auth_service.dart';


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
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailPassword(
        emailController.text,
        passedController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
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
              const logo(),
              const SizedBox(height: 10),
              Text(
                '아이디와 비밀번호를 입력하여 로그인하세요!',
                style: TextStyle(
                  color: Colors.grey[600],
                  //fontSize: 10,
                ),
              ),
              const SizedBox(height: 15),

              //username
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 20,),
                  const Text('이메일   ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                  //const SizedBox(width: 10,),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: emailController,
                      obscureText: false,
                    ),
                  ),
                  const SizedBox(width: 20,),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              //passwd
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 20,),
                  const Text('비밀번호',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                  //const SizedBox(width: 10,),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: passedController,
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(width: 20,),
                ],
              ),

              const SizedBox(height: 15),

/////// 다시             
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      '아이디/비밀번호 찾기',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
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
