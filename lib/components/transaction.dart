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
      borderRadius: BorderRadius.circular(10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.grey[100],
            height: 50,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    transactionName,
                    style: const TextStyle(
                      fontSize: 16,),
                  ),
                  Text(
                    '${expenseOrIncome == 'expense' ? '-' : '+'} $money',
                    style: TextStyle(
                        fontSize: 16,
                        color: (expenseOrIncome == 'expense'
                            ? Colors.red
                            : Colors.green)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5,),
        ],
      ),
    );
  }
}
