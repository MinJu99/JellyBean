import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  
  /*final titleController = TextEditingController(); //제목
  final choiceDayController = TextEditingController(); //날짜
  final timeController = TextEditingController(); //시간
  final placeController = TextEditingController(); //장소*/

  DateTime? _selectedDate;

  @override
  void initState(){
    super.initState();
    dateController.text = _selectedDate?.toIso8601String().substring(0,10) ?? "Select Date";
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Event")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText:"Enter event title"),//alignLabelWithHint:
            
            ),
            const SizedBox(height: 16),
            TextField(
              controller: dateController, 
              readOnly: true, 
              onTap: () async{
                DateTime? newDate = await showDatePicker(
                  context: context, 
                  initialDate: _selectedDate != null ? _selectedDate! : DateTime.now(), 
                  firstDate: DateTime(2000), 
                  lastDate: DateTime(2099),
                );
                if (newDate != null) {
                  setState(() {
                    _selectedDate = newDate;
                    dateController.text =
                      newDate.toIso8601String().substring(0,10);
                  });
                }
              },
        
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              onPressed: () {
                if (_selectedDate != null) {
                  FirebaseFirestore.instance.collection('events').add({
                    'title': titleController.text,
                    'date': _selectedDate,
                  });
                  Navigator.pop(context);
                } else{
                }
              }, 
              child: Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}