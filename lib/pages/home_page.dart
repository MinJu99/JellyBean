import 'package:flutter/material.dart';
import 'package:test/components/drawer.dart';
import 'package:test/components/my_textfield.dart';
import 'package:test/pages/profile_page.dart';
import 'package:test/pages/setting_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: 
          Column(
            children: [
              SizedBox(height: 75,),
              Container(
                padding: const EdgeInsets.all(8),
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    //color: Colors.grey[300],
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(4.0, 4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                      const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                    ]
                  ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '공 지 사 항',
                        style: TextStyle(color: Colors.grey[500], fontSize: 15),
                      ),
                      Text(
                        '등록된 공지사항이 없습니다.',
                        style: TextStyle(color: Colors.grey[800], fontSize: 17),
                      ),
                    ],
                    
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
