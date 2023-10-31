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
      //padding: const EdgeInsets.all(20.0), //8.0
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Container(
        //padding: EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,  //grey[300],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400,
                  offset: const Offset(4.0, 4.0),
                  blurRadius: 10.0,
                  spreadRadius: 1.0),
              
            ]),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'My Point', 
                style: TextStyle(color: Colors.grey[500], fontSize: 15),
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
                      const Icon(Icons.arrow_upward),
                      Row(
                        children: [
                          const Text('입금 '),
                          Text(income),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.arrow_downward),
                      Row(
                        children: [
                          const Text('지출 '),
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
      ),
    );
  }
}
