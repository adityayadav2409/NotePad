// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:notepad/model/notes_model.dart';

// ignore: must_be_immutable
class EditNotes extends StatefulWidget {
  NotesModel note;

  EditNotes({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  final TextEditingController _title = TextEditingController();

  final TextEditingController _body = TextEditingController();

  final myBox = Hive.box('notes');

  @override
  void initState() {
    super.initState();
    debugPrint("note received = ${widget.note.noteBody}");

    _title.text = widget.note.noteTitle;
    _body.text = widget.note.noteBody;
  }

  // ignore: non_constant_identifier_names
  void UpdateNote(context) {
    widget.note.noteTitle = _title.text;
    widget.note.noteBody = _body.text;

    widget.note.save();

    Navigator.of(context).pop();
    //}
  }

  showToast(context, message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Notes"),
        backgroundColor: const Color.fromARGB(255, 236, 220, 43),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => UpdateNote(context),
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            TextField(
              controller: _title,
              //minLines: 6,
              maxLines: null,
              decoration: const InputDecoration(
                  hintText: "Enter Edited Note Title",
                  hintStyle: TextStyle(color: Color.fromARGB(225, 98, 94, 94)),
                  fillColor: Color.fromRGBO(66, 224, 215, 215),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _body,
              minLines: 6,
              maxLines: null,
              decoration: const InputDecoration(
                  hintText: "Enter Edited Note Body",
                  hintStyle:
                      TextStyle(color: Color.fromARGB(224, 226, 216, 216)),
                  fillColor: Color.fromRGBO(66, 224, 215, 215),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent))),
            ),
          ],
        ),
      ),
    );
  }
}
