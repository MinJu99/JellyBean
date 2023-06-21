import 'package:flutter/material.dart';
import 'package:test/components/logo.dart';

class SearchGroup extends StatefulWidget {
  const SearchGroup({super.key});

  @override
  State<SearchGroup> createState() => _SearchGroupState();
}

class _SearchGroupState extends State<SearchGroup> {
  final GcodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          logo(),
          const SizedBox(
            height: 180,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey.shade400,
                  ),
                ),
                child: Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: TextField(
                  controller: GcodeController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      hintText: '코드 입력',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 20,
                      )),
                ),
                width: 200,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
