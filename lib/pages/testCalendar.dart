import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test/pages/calendar.dart'; //
import 'package:test/screens/add_event_screen.dart';
import 'package:test/screens/edit_event_screen.dart';
import '../models/event.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  @override
  State<CalendarPage> createState() => _TestCalendar();
}

class _TestCalendar extends State<CalendarPage> {
  DateTime? _selectedDate; //이벤트용(event_screen)

  DateTime selectedDay = DateTime(
    //ㄱㅊ
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //
      appBar: AppBar(
        title: Row(
          children: [
            Text(_selectedDate != null
                ? _selectedDate!.toIso8601String().substring(0, 10)
                : "All Events"),
            if (_selectedDate != null)
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _selectedDate = null;
                  });
                },
              )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2099));
                if (newDate != null) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                }
              },
              icon: Icon(Icons.calendar_today))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            //Calendar(),
            TableCalendar(
              locale: 'ko_KR', //
              firstDay: DateTime.utc(1900, 1, 1), //DateTime(2022),
              lastDay: DateTime.utc(2999, 12, 31), //DateTime(2023),
              //focusedDay: DateTime.now(),
              focusedDay: focusedDay,
              onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                //선택된 날짜 상태 갱신
                setState(() {
                  this.selectedDay = selectedDay;
                  this.focusedDay = focusedDay;
                });
              },
              selectedDayPredicate: (DateTime day) {
                //selecteDay와 같은 날짜의 모양을 바꿈
                return isSameDay(selectedDay, day);
              },
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _selectedDate == null
                  ? FirebaseFirestore.instance.collection('events').snapshots()
                  : FirebaseFirestore.instance
                      .collection('events')
                      .where('date', isEqualTo: _selectedDate)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error fetching data: ${snapshot.error}"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<Event> events =
                    snapshot.data!.docs.map((e) => Event.fromJson(e)).toList();
                return Flexible(
                  child: ListView.builder(
                    //
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical, //추가 85 86 87
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      Event event = events[index];
                      return Dismissible(
                        key: Key(event.title),
                        onDismissed: (direction) {
                          setState(() {
                            FirebaseFirestore.instance
                                .collection('events')
                                .doc(event.id)
                                .delete();
                          });
                        },
                        child: ListTile(
                          title: Text(event.title),
                          subtitle: Text(
                            event.date.toIso8601String().substring(0, 10),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditEventScreen(event: event))); //83
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddEventScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
