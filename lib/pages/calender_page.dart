import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:table_calendar/table_calendar.dart';

// 캘린더 화면
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  // 오늘 날짜 표시
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendar(
          firstDay: DateTime.utc(2021, 10, 16),
          lastDay: DateTime.utc(20230, 3, 14),
          focusedDay: DateTime.now(),
          onDaySelected: _onDaySelected,
          selectedDayPredicate: (day) => isSameDay(day, today),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: false,
          ),
          calendarStyle: CalendarStyle(
            canMarkersOverflow: true,
          ),
          calendarBuilders: CalendarBuilders(dowBuilder: (Context, day) {
            switch (day.weekday) {
              case 1:
                return Center(
                  child: Text('월'),
                );
              case 2:
                return Center(
                  child: Text('화'),
                );
              case 3:
                return Center(
                  child: Text('수'),
                );
              case 4:
                return Center(
                  child: Text('목'),
                );
              case 5:
                return Center(
                  child: Text('금'),
                );
              case 6:
                return Center(
                  child: Text(
                    '토',
                    style: TextStyle(color: Colors.blue),
                  ),
                );
              case 7:
                return Center(
                  child: Text(
                    '일',
                    style: TextStyle(color: Colors.red),
                  ),
                );
            }
          })),
    );
  }
}
