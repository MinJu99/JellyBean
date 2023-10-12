import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test/components/loading_circle.dart';
import 'package:test/components/plus_button.dart';
import 'package:test/components/top_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/services/util/swipe_card.dart';
import '../components/transaction.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _isIncome = false;
  //controller
  final _controller = PageController();

  final moneyController = TextEditingController(); //금액
  final useController = TextEditingController(); //사용처
  final breakdownController = TextEditingController(); //내역

  //새로운 데이터 입력
  // 데이터 로딩까지 기다리기
  bool timerHasStarted = false;


  // 새로운 입출금 내역
  void _newTransaction() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          actions: <Widget>[
            const SizedBox(height: 10,),
            
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 10,),
                const Text('금액    ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 25,),
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: moneyController,
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
                //const SizedBox(width: 10,),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 10,),
                const Text('사용처',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 25,),
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: useController, 
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 10,),
                const Text('내역    ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 25,),
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: breakdownController,
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
              ], 
            ), 
            const SizedBox(height: 30,),
            Row(
              children: [
                IconButton(
                 icon: const Icon(Icons.camera_alt),
                  color: const Color.fromARGB(255,211,195,227), //누르면 카메라
                  iconSize: 35,
                  onPressed: () async {
                    var picker = ImagePicker();
                    var image = await picker.pickImage(source: ImageSource.camera);
                  },
                ),
                const SizedBox(width: 10,),
                MaterialButton(
                  color: Colors.white,
                  child: const Text(
                    '취소',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }, 
                ),
                const SizedBox(width: 10,),
                MaterialButton(
                  color: Colors.white,
                  child: const Text(
                    '추가',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); //닫히게 함
                  }, 
                )
              ],
            ),

            
          ],
        );
        
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  //grey[300],
      body: Padding(
        padding: const EdgeInsets.all(7.0), //15.0
        child: Column(
          children: [
            const SizedBox(height: 75,),
            SizedBox(
              height: 160,
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                children: const [
                  TopNeuCard(
                    balance: '\$ 20,000',
                    expense: '\$ 10,000',
                    income: '\$ 30,000'),
                  myPointCard(
                    balance: '\$ 17,000',
                    expense: '\$ 2,000',
                    income: '\$ 8,000'),
                ],
              ),
            ),

            //const SizedBox(height: 5),
            SmoothPageIndicator(
              controller: _controller, 
              count: 2,
              effect: WormEffect(
                dotHeight: 12,
                dotWidth: 12,
                dotColor: Color.fromARGB(255,211,195,227),
                activeDotColor: Color.fromARGB(255, 186, 158, 215),
              ),
              //effect: ExpandingDotsEffect(activeDotColor: Color.fromARGB(255,211,195,227),),
            ),

            /*
            TopNeuCard(
                balance: '\$ 20,000',
                expense: '\$ 10,000',
                income: '\$ 30,000'),
            */

            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      MyTransaction(expenseOrIncome: 'income', transactionName: 'Teaching', money: '300'),
                      MyTransaction(expenseOrIncome: 'expense', transactionName: 'dinner(09/23)', money: '8000'),
                    ],
                  ),
                ),
              ),
            ),
            PlusButton(
              function: _newTransaction,
            ),
          ],
        ),
      ),
    );
  }
}
