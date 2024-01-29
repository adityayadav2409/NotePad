import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 0)
class NotesModel extends HiveObject {
  @HiveField(0)
  String noteTitle;

  @HiveField(1)
  String noteBody;

  NotesModel({required this.noteTitle, required this.noteBody});
}
