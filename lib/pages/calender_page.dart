import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
//import 'package:test/components/plus_button.dart';
//import 'package:google_nav_bar/google_nav_bar.dart';

class CalendarPage extends StatefulWidget {
  //const CalendarPage({Key? key}) : super(key: key);
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime today = DateTime.now();
  DateTime? _selectedDate;

  Map<String, List> mySelectedEvents = {};

  final titleController = TextEditingController(); //제목
  final choiceDayController = TextEditingController(); //날짜
  final timeController = TextEditingController(); //시간
  final placeController = TextEditingController(); //장소

  final isSelected = <bool>[false, false, false]; 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = today;

    loadPreviousEvents();
  }

  loadPreviousEvents() {
    mySelectedEvents = {//여기에 입력되어야 캘린더에 유지됨
      "2023-09-13": [
        //{"eventDescp": "11", "eventTitle": "111"},
        //{"eventDescp": "22", "eventTitle": "22"}
        {"eventTitle": "11",
         "eventDay": "11",
         "eventTime": "11",
         "eventPlace": "11",
        }
      ],
      
    };
  }
  

  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        //title: const Text('일정 추가',textAlign: TextAlign.center,),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            child: const Text('추가'),
            onPressed: () {
              if (titleController.text.isEmpty) {
                //(titleController.text.isEmpty && choiceDayController.text.isEmpty)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('입력되지 않았습니다.'),
                    duration: Duration(seconds: 2),
                  ),
                );

                //Navigator.pop(context);
                return;
              } else {
                //print(titleController.text);
                //print(choiceDayController.text);

                setState(() {
                  if (mySelectedEvents[
                          DateFormat('yyyy-MM-dd').format(_selectedDate!)] !=
                      null) {
                    mySelectedEvents[
                            DateFormat('yyyy-MM-dd').format(_selectedDate!)]
                        ?.add({
                      "eventTitle": titleController.text,
                      "eventDay": choiceDayController.text,
                      "eventTime": timeController.text,
                      "eventPlace": placeController.text,
                    });
                  } else {
                    mySelectedEvents[
                        DateFormat('yyyy-MM-dd').format(_selectedDate!)] = [
                      {
                        "eventTitle": titleController.text,
                        "eventDay": choiceDayController.text,
                        "eventTime": timeController.text,
                        "eventPlace": placeController.text,
                      }
                    ];
                  }
                });

                print(
                    "New Event for backend developer ${json.encode(mySelectedEvents)}");
                titleController.clear();
                choiceDayController.clear();
                timeController.clear();
                placeController.clear();
                Navigator.pop(context);
                return;
              }
            },
          )
        ],
        //PlusButton
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //ElevatedButton.icon( onPressed: () { // Respond to button press }, icon: Icon(Icons.add, size: 18), label: Text("CONTAINED BUTTON"), )
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    '취소', 
                    style: TextStyle(
                      fontSize: 17,
                      color:  Color.fromARGB(255, 83, 83, 84),
                    ), // Colors.grey.shade300
                  ),
                ),
                const SizedBox(width: 50,),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    '추가', 
                    style: TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(255, 184, 138, 230),
                    ),
                  ),
                ),
                /*
                ElevatedButton.icon( 
                  style: ElevatedButton.styleFrom( 
                    backgroundColor: Colors.white,
                    ),
                  onPressed: () => Navigator.pop(context), 
                  icon: Icon(Icons.add, size: 18), 
                  label: Text("추가", style: TextStyle(
                    color: Color.fromARGB(255, 184, 138, 230),),
                  ), 
                ),
                */
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, //사이 공간 동일
              children: [
                //ElevatedButton.icon( onPressed: () { // Respond to button press }, icon: Icon(Icons.add, size: 18), label: Text("CONTAINED BUTTON"), )
                //ElevatedButton( onPressed: () { // Respond to button press }, child: Text('CONTAINED BUTTON'), )
                
                /*ToggleButtons( 
                  color: Colors.black.withOpacity(0.60), 
                  selectedColor: Color(0xFF6200EE), 
                  selectedBorderColor: Color(0xFF6200EE), 
                  fillColor: Color(0xFF6200EE).withOpacity(0.08), 
                  splashColor: Color(0xFF6200EE).withOpacity(0.12), 
                  hoverColor: Color(0xFF6200EE).withOpacity(0.04), 
                  borderRadius: BorderRadius.circular(4.0), 
                  constraints: BoxConstraints(minHeight: 36.0), 
                  isSelected: isSelected, onPressed: (index) {Respond to button selection setState(() { 
                      isSelected[index] = !isSelected[index]; 
                    }
                  ); 
                    }, 
                    children: [ 
                      Padding( 
                        padding: EdgeInsets.symmetric(horizontal: 16.0), 
                        child: Text('BUTTON 1'), 
                        ), 
                        Padding( 
                          padding: EdgeInsets.symmetric(horizontal: 16.0), 
                          child: Text('BUTTON 2'), 
                        ), 
                        Padding( 
                          padding: EdgeInsets.symmetric(horizontal: 16.0), 
                          child: Text('BUTTON 3'), 
                        ), 
                      ], 
                    ),
                */
                
                ElevatedButton( 
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 27.0),
                    backgroundColor: Colors.grey.shade300, //primary: Colors.
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                    onPressed: () => Navigator.pop(context), 
                  child: const Text('내 일정', 
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                //const SizedBox(width: 25,),
                ElevatedButton( 
                  style: ElevatedButton.styleFrom( 
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    backgroundColor: Colors.grey.shade300, //primary: Colors.
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                    onPressed: () => Navigator.pop(context), 
                  child: const Text('모임 일정', 
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                // 둘 중 하나 선택하는 버튼으로 바꿀까(위 주석처리 연구)
                //모두에게 공개 체크박스
              ]
            ),

            Row(
              children: [
                const SizedBox(width: 10,),
                const Text('제목',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 25,),
                SizedBox(
                  //margin: EdgeInsets.all(8),
                  width: 150,
                  //margin: EdgeInsets.all(8),
                  child: TextField(
                    controller: titleController,
                    textCapitalization: TextCapitalization.words,
                    //decoration: const InputDecoration(labelText: '제목',),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                const SizedBox(width: 10,),
                const Text('날짜',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 25,),
                SizedBox(
                  //margin: EdgeInsets.all(8),
                  width: 150,
                  //margin: EdgeInsets.all(8),
                  child: TextField(
                    controller: choiceDayController,
                    textCapitalization: TextCapitalization.words,
                    //decoration: const InputDecoration(labelText: '날짜',),
                    /*
                    margin: EdgeInsets.all(8),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400),),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400),),
                    ),
                    */
                  ),
                ),
              ],
            ),

            Row(
              children: [
                const SizedBox(width: 10,),
                const Text('시간',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 25,),
                SizedBox(
                  //margin: EdgeInsets.all(8),
                  width: 150,
                  //margin: EdgeInsets.all(8),
                  child: TextField(
                    controller: timeController,
                    textCapitalization: TextCapitalization.words,
                    //decoration: const InputDecoration(labelText: '시간',),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                const SizedBox(width: 10,),
                const Text('장소',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 25,),
                SizedBox(
                  //margin: EdgeInsets.all(8),
                  width: 150,
                  //margin: EdgeInsets.all(8),
                  child: TextField(
                    controller: placeController,
                    textCapitalization: TextCapitalization.words,
                    //decoration: const InputDecoration(labelText: '장소',),
                  ),
                ),
              ],
            ),
          ],

        ),

        //actions: [] 원래위치
        
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            // 오류 locale:'ko_KR.UTF-8',

            firstDay: DateTime.utc(1900, 1, 1), //DateTime(2022),
            lastDay: DateTime.utc(2999, 12, 31), //DateTime(2023),
            focusedDay: DateTime.now(),
            
            calendarStyle: const CalendarStyle(
              canMarkersOverflow: true, //마커 영역 밖으로 안나감 : t
              markerSize: 8.0,
              markersMaxCount: 3,
              markersAlignment: Alignment.bottomCenter,
              markerDecoration: BoxDecoration(
                color: Color.fromARGB(255, 184, 138, 230),
                shape: BoxShape.circle,
              ),
            ),
            
            //여기부터 기존과 다름
            calendarFormat: _calendarFormat,
            calendarBuilders: CalendarBuilders(dowBuilder: (Context, day) {
              switch (day.weekday) {
                case 1:
                  return const Center(child: Text('월'),);
                case 2:
                  return const Center(child: Text('화'),);
                case 3:
                  return const Center(child: Text('수'),);
                case 4:
                  return const Center(child: Text('목'),);
                case 5:
                  return const Center(child: Text('금'),);
                case 6:
                  return const Center(child: Text('토',
                      style: TextStyle(color: Colors.blue),),);
                case 7:
                  return const Center(child: Text('일',
                      style: TextStyle(color: Colors.red),),);
              }
              return null;
            }),
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDate, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDate = selectedDay;
                  today = focusedDay;
                });
              }
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              today = focusedDay;
            },
            eventLoader: _listOfDayEvents,
          ),
          
          ..._listOfDayEvents(_selectedDate!).map(
            (myEvents) => ListTile(
              leading: const Icon(
                Icons.done,
                color: Colors.teal,
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Event Title:   ${myEvents['eventTitle']}'),
              ),
              subtitle: Text('Event Day:   ${myEvents['eventDay']}'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Text('추가'),
        icon: const Icon(Icons.add,),
        backgroundColor: const Color.fromARGB(255, 214, 201, 227),
        //splashColor: Color.fromARGB(255, 184, 138, 230),
      ),
    );
  }
}
