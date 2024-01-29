import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notepad/model/notes_model.dart';

import 'home/home.dart';

void main() async {
  //initialize hive flutter
  await Hive.initFlutter();

  Hive.registerAdapter(NotesModelAdapter());

//open hive box
  await Hive.openBox('notes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ('Centra Note App'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
