import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notepad/Page/add_notes.dart';
import 'package:notepad/Page/edit_notes.dart';
import 'package:notepad/constraints/colors.dart';
import 'package:notepad/model/notes_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final myBox = Hive.box('notes');

  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  void editNote(context, NotesModel note) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditNotes(note: note)),
    );
  }

  void deleteNote(NotesModel note) async {
    await note.delete();
  }

  void gotoAddNotes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNotes(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          " KEEP NOTES",
        ),
        iconTheme: const IconThemeData(color: Colors.black38),
        backgroundColor: const Color.fromARGB(255, 235, 227, 69),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (gotoAddNotes),
        backgroundColor: const Color.fromARGB(255, 235, 227, 69),
        child: const Icon(Icons.add, color: Color.fromARGB(255, 0, 0, 0)),
      ),
      body: ValueListenableBuilder(
        valueListenable: myBox.listenable(),
        builder: (context, box, _) {
          final data = box.values.toList().cast<NotesModel>();

          if (data.isEmpty) {
            // If there are no notes, display a centered text
            return const Center(
              child: Text(
                "Create Your Notes Here",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w100,
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView.separated(
              itemCount: data.length,
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                return ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: getRandomColor(),
                  title: Text(data[index].noteTitle),
                  subtitle: Text(data[index].noteBody),
                  leading: IconButton(
                    onPressed: () => editNote(context, data[index]),
                    icon: const Icon(Icons.edit),
                  ),
                  trailing: IconButton(
                    onPressed: () => deleteNote(data[index]),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
