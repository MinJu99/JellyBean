import 'package:flutter/material.dart';
import 'package:test/components/logo.dart';
import 'package:test/pages/create_group.dart';
import 'package:test/pages/search_group.dart';

import 'group_list_page.dart';

class CreateOrSearchGroup extends StatefulWidget {
  const CreateOrSearchGroup({super.key});

  @override
  State<CreateOrSearchGroup> createState() => _CreateOrSearchGroupState();
}

class _CreateOrSearchGroupState extends State<CreateOrSearchGroup> {

  void goToGroupListPage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GroupListPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String logoText = "JellyBean";
    return Scaffold(
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            logo(),  //logo.dart 수정함
            //const SizedBox(
            //  height: 100,
            //),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateGroup(),
                            ));
                      },
                      child: Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 80,
                          color: Color.fromARGB(255, 186, 158, 215),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text(
                      '생성하기',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 19,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchGroup(),
                            ));
                      },
                      child: Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: const Icon(
                          Icons.search,
                          size: 80,
                          color: Color.fromARGB(255, 186, 158, 215),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text(
                      '모임 찾기',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 19,
                      ),
                    )
                  ],
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    iconSize: 30,
                    onPressed: goToGroupListPage,
                  ),
                ),
                const SizedBox(height: 40,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
