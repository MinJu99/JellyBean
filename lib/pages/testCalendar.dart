import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test/components/drawer.dart';
import 'package:test/components/logo.dart';
import 'package:test/pages/calendar.dart'; //
import 'package:test/pages/profile_page.dart';
import 'package:test/screens/add_event_screen.dart';
import 'package:test/screens/edit_event_screen.dart';
import 'package:test/services/group/get_group_name.dart';
import 'package:test/services/group/get_logo_name.dart';
import '../models/event.dart';
import 'package:test/pages/group_list_page.dart';
import 'package:test/pages/inquiry_page.dart';
import 'package:test/pages/notice_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CalendarPage extends StatefulWidget {
  final String groupId;
  const CalendarPage({required this.groupId, super.key});
  @override
  State<CalendarPage> createState() => _TestCalendar();
}

class _TestCalendar extends State<CalendarPage> {
  DateTime? _selectedDate; //이벤트용(event_screen)

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  void goToGListPage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GroupListPage(),
      ),
    );
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void goToNoticePage() {
    //Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NoticePage(),
      ),
    );
  }

  void goToInquiryPage() {
    //Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InquiryPage(),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  String groupName = "";

  void getGName() {
    groupName = GetGroupName(documentId: widget.groupId).toString();
  }

  @override
  Widget build(BuildContext context) {
    getGName();
    return Scaffold(
      key: _globalKey,
      endDrawer: MyDrawer(
        //Drawer->endDrawer
        onProfileTap: goToProfilePage,
        onSignOut: signOut,
        onHomeTap: goToGListPage,
        onNoticeTap: goToNoticePage,
        onInquiryTap: goToInquiryPage,
      ),
      resizeToAvoidBottomInset: false, //
      /*appBar: AppBar(
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
      ),*/
      body: Stack(
        //SafeArea(
        alignment: Alignment.topRight,
        children: [
          Positioned(
            top: 40, //5
            left: 10,
            child: GetLogoName(documentId: widget.groupId,)
          ),
          Positioned(
            top: 70, //30
            right: 60,
            child: IconButton(
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
                icon: Icon(Icons.calendar_today)),
          ),
          Positioned(
            top: 70, //30
            right: 20,
            child: IconButton(
              //padding: const EdgeInsets.all(30),
              icon: Icon(Icons.menu),
              color: Colors.black,
              onPressed: () {
                _globalKey.currentState!
                    .openEndDrawer(); //openDrawer->openEndDrawer
              },
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /*Text(_selectedDate != null
                ? _selectedDate!.toIso8601String().substring(0, 10)
                : "All Events"),*/

              SizedBox(height: 110),
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
                    ? FirebaseFirestore.instance
                        .collection('Groups')
                        .doc(widget.groupId)
                        .collection('events')
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('Groups')
                        .doc(widget.groupId)
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
                  List<Event> events = snapshot.data!.docs
                      .map((e) => Event.fromJson(e))
                      .toList();
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
                                  .collection('Groups')
                                  .doc(widget.groupId)
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
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEventScreen(
                        groupId: widget.groupId,
                      )));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
