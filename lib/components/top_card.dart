import 'package:flutter/material.dart';

// 정산시 남은 회비 표시하는 카드

class TopNeuCard extends StatelessWidget {
  const TopNeuCard({
    super.key,
    required this.balance,
    required this.expense,
    required this.income,
  });
  final String balance;
  final String income;
  final String expense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8),
        height: 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'B A L A N C E',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
              Text(
                balance,
                style: TextStyle(color: Colors.grey[800], fontSize: 35),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.arrow_upward),
                      Column(
                        children: [
                          Text('입금액'),
                          Text(income),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.arrow_downward),
                      Column(
                        children: [
                          Text('지출액'),
                          Text(expense),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[300],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade500,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
            ]),
      ),
    );
  }
}
