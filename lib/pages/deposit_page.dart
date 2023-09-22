import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test/components/google_sheets_api.dart';
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
  void _enterTransaction() {
    GoogleSheetsApi.insert(
      _textcontrollerITEM.text,
      _textcontrollerAMOUNT.text,
      _isIncome,
    );
  }

  // 데이터 로딩까지 기다리기
  bool timerHasStarted = false;

  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

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
                  onPressed: () {
                    print('camera button is clicked');
                  },
                ),
                const SizedBox(width: 10,),
                MaterialButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }, 
                  child: const Text(
                    '취소',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 10,),
                MaterialButton(
                  color: Colors.white,
                  child: const Text(
                    '추가',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _enterTransaction();
                      Navigator.of(context).pop();
                    }
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
    if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
      startLoading();
    }

    return Scaffold(
      backgroundColor: Colors.white, //grey[300],
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                children: const [
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

            const SizedBox(height: 10),
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
                      const SizedBox(
                        height: 20,
                      ),
                      const MyTransaction(expenseOrIncome: 'income', transactionName: 'Teaching', money: '300'),
                      Expanded(
                        child: GoogleSheetsApi.loading == true
                            ? const LoadingCircle()
                            : ListView.builder(
                                itemCount:
                                    GoogleSheetsApi.currentTransactions.length,
                                itemBuilder: (context, index) {
                                  return MyTransaction(
                                      expenseOrIncome: GoogleSheetsApi
                                          .currentTransactions[index][2],
                                      transactionName: GoogleSheetsApi
                                          .currentTransactions[index][0],
                                      money: GoogleSheetsApi
                                          .currentTransactions[index][1]);
                                },
                              ),
                      )
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
