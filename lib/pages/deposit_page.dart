import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test/components/google_sheets_api.dart';
import 'package:test/components/loading_circle.dart';
import 'package:test/components/plus_button.dart';
import 'package:test/components/top_card.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../components/transaction.dart';

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
    Timer.periodic(Duration(seconds: 1), (timer) {
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
          title: Text('새로 입력하기'),
          content: Text('지출내역을 입력하세요'),
          actions: <Widget>[
            MaterialButton(
              color: Colors.grey[600],
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            MaterialButton(
              color: Colors.grey[600],
              child: Text(
                'Enter',
                style: TextStyle(color: Colors.white),
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
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TopNeuCard(
                balance: '\$ 20,000',
                expense: '\$ 10,000',
                income: '\$ 30,000'),
            Expanded(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: GoogleSheetsApi.loading == true
                            ? LoadingCircle()
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
