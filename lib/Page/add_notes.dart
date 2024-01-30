import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
// ignore: unused_import
import 'package:intl/intl.dart';
import 'package:notepad/model/notes_model.dart';
//import 'package:notepad/constraints/dat_time_format.dart';

class AddNotes extends StatelessWidget {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();

  final myBox = Hive.box('notes');

  AddNotes({super.key});

  void saveNote(context) {
    //store user entered data into local storage
    final myobj = NotesModel(noteTitle: _title.text, noteBody: _body.text);

    myBox.add(myobj);

    myobj.save();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
        backgroundColor: const Color.fromARGB(255, 235, 227, 69),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => saveNote(context),
            icon: const Icon(
              Icons.check,
              color: Color.fromARGB(179, 0, 0, 0),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            TextField(
              controller: _title,
              // minLines: 6,
              maxLines: null,
              decoration: const InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Color.fromARGB(255, 98, 94, 94)),
                  fillColor: Color.fromARGB(66, 224, 215, 215),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _body,
              minLines: 2,
              maxLines: null,
              decoration: const InputDecoration(
                  hintText: " Note",
                  hintStyle: TextStyle(color: Color.fromARGB(255, 98, 94, 94)),
                  fillColor: Color.fromARGB(66, 224, 215, 215),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent))),
            ),
            /*Text(
              'Edited : ${fullDate()}',
              style: TextStyle(
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade800),
            )*/
          ],
        ),
      ),
    );
  }
}
