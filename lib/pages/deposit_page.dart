import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test/components/loading_circle.dart';
import 'package:test/components/plus_button.dart';
import 'package:test/components/top_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/services/util/swipe_card.dart';
import 'dart:io';
import '../components/transaction.dart';
import 'package:test/components/my_textfield.dart';
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
  bool _isIncome = false;
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
            SizedBox(height: 10,),
            
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 10,),
                Text('금액    ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 25,),
                Container(
                  child: TextField(
                    controller: moneyController,
                    textCapitalization: TextCapitalization.words,
                  ),
                  width: 150,
                ),
                //const SizedBox(width: 10,),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 10,),
                Text('사용처',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 25,),
                Container(
                  child: TextField(
                    controller: useController,
                    textCapitalization: TextCapitalization.words,
                  ),
                  width: 150,
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 10,),
                Text('내역    ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 25,),
                Container(
                  child: TextField(
                    controller: breakdownController,
                    textCapitalization: TextCapitalization.words,
                  ),
                  width: 150,
                ),
              ], 
            ), 
            const SizedBox(height: 30,),
            Row(
              children: [
                IconButton(
                 icon: Icon(Icons.camera_alt),
                  color: Color.fromARGB(255,211,195,227), //누르면 카메라
                  iconSize: 35,
                  onPressed: () {
                    print('camera button is clicked');
                  },
                ),
                SizedBox(width: 10,),
                MaterialButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }, 
                  child: Text(
                    '취소',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 10,),
                MaterialButton(
                  color: Colors.white,
                  child: Text(
                    '추가',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    var picker = ImagePicker();
                    var image = await picker.pickImage(source: ImageSource.camera);
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
      backgroundColor: Colors.white, //grey[300],
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              height: 150,
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                children: [
                  TopNeuCard(
                    balance: '\$ 20,000',
                    expense: '\$ 10,000',
                    income: '\$ 30,000'),
                  myPointCard(
                    balance: '\$ 20,000',
                    expense: '\$ 10,000',
                    income: '\$ 30,000'),
                ],
              ),
            ),

            SizedBox(height: 10),
            SmoothPageIndicator(
              controller: _controller, 
              count: 2,
              //effect: ExpandingDotsEffect(activeDotColor: colors.grey.shade800,),
            ),

            /*
            TopNeuCard(
                balance: '\$ 20,000',
                expense: '\$ 10,000',
                income: '\$ 30,000'),
            */

            Expanded(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      MyTransaction(expenseOrIncome: 'income', transactionName: 'Teaching', money: '300'),
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
