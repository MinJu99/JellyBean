import 'package:flutter/material.dart';
import 'package:test/pages/create_group.dart';
import 'package:test/pages/home_page.dart';
import 'package:test/pages/search_group.dart';
import 'package:firebase_auth/firebase_auth.dart';



class CreateOrSearchGroup extends StatefulWidget {
  const CreateOrSearchGroup({super.key});

  @override
  State<CreateOrSearchGroup> createState() => _CreateOrSearchGroupState();
}


class _CreateOrSearchGroupState extends State<CreateOrSearchGroup> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //const SizedBox(
            //  height: 50,
            //),
            Padding(
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
                              builder: (context) => CreateGroup(),
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
                        child: Icon(
                          Icons.add,
                          size: 80,
                          color: Color.fromARGB(255,211,195,227),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      '생성하기',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
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
                              builder: (context) => SearchGroup(),
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
                        child: Icon(
                          Icons.search,
                          size: 80,
                          color: Color.fromARGB(255,211,195,227),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      '모임 찾기',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
                      ),
                    )
                  ],
                )
              ],
            ),
            //const SizedBox(
            //  height: 100,
            //),
            Padding(
              padding: const EdgeInsets.all(15),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                iconSize: 30,
                onPressed: signUserOut,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
