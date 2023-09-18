import 'package:flutter/material.dart';

// 거래내역 표시 UI

class MyTransaction extends StatelessWidget {
  final String transactionName;
  final String money;
  final String expenseOrIncome;

  const MyTransaction(
      {super.key,
      required this.expenseOrIncome,
      required this.transactionName,
      required this.money});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,  //grey[200],
        height: 50,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(transactionName),
              Text(
                (expenseOrIncome == 'expense' ? '-' : '+') + ' \$ ' + money,
                style: TextStyle(
                    color: (expenseOrIncome == 'expense'
                        ? Colors.red
                        : Colors.green)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
