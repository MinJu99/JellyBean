import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
  
}

class _CalendarState extends State<Calendar> {
  //DateTime? _selectedDate;
  DateTime selectedDay = DateTime(  //ㄱㅊ
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  //DateTime? _selectedDay;
  DateTime focusedDay = DateTime.now(); //ㄱㅊ
  //DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [//<Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                color: Color.fromARGB(255, 232, 224, 239),
                child: TableCalendar(
                  locale: 'ko_KR',//
                  firstDay: DateTime.utc(1900, 1, 1), //DateTime(2022),
                  lastDay: DateTime.utc(2999, 12, 31), //DateTime(2023),
                  //focusedDay: DateTime.now(),
                  focusedDay: focusedDay,
                  onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                    //선택된 날짜 상태 갱신
                    setState(() {
                      this.selectedDay = selectedDay;
                      this.focusedDay = focusedDay;
                    }
                    );
                  },
                  selectedDayPredicate: (DateTime day) {
                    //selecteDay와 같은 날짜의 모양을 바꿈
                    return isSameDay(selectedDay, day);
                  },
                ),
              ),
            ],
              ),
                ),
    );

}
}