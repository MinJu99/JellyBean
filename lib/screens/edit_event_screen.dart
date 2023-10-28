import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/event.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditEventScreen extends StatefulWidget {
  final Event event;
  EditEventScreen({required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  void initState() {
    titleController.text = widget.event.title;
    dateController.text = widget.event.date.substring(0,10);    
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Event")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
            ),
            const SizedBox(height: 16,),
            TextField(
              controller: dateController,
              readOnly: true,
              onTap: () async {
                DateTime? newDate = await showDatePicker(
                  context: context, 
                  initialDate: DateTime.parse(widget.event.date), 
                  firstDate: DateTime(2000), 
                  lastDate: DateTime(2099)
                );
                if (newDate != null) {
                  setState(() {
                    dateController.text = newDate.toIso8601String().substring(0,10);
                  });
                }
              },
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              onPressed: (){
                FirebaseFirestore.instance
                  .collection('event')
                  .doc(widget.event.id)
                  .update({
                    'title': titleController.text,
                    'date': DateTime.parse(dateController.text)
                  });
                  Navigator.pop(context);
              }, 
              child: Text("Save"),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                  .collection('events')
                  .doc(widget.event.id)
                  .delete();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }
}