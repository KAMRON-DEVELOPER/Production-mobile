import 'package:hive/hive.dart';
import 'package:mobile/models/note.dart';

class NoteModel extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? body;
  @HiveField(2)
  bool? isPinned;
  @HiveField(3)
  int? sequenceNumber;
  @HiveField(4)
  String? category;
  @HiveField(5)
  String? createdTime;
  @HiveField(6)
  String? updatedTime;

  NoteModel({
    this.id,
    this.body,
    this.isPinned,
    this.sequenceNumber,
    this.category,
    this.createdTime,
    this.updatedTime,
  });

  factory NoteModel.fromNote(Note note) {
    return NoteModel(
      id: note.id,
      body: note.body,
      category: note.category,
      isPinned: note.isPinned,
      sequenceNumber: note.sequenceNumber,
      createdTime: note.createdTime,
      updatedTime: note.updatedTime,
    );
  }

  Map<String, String?> toJson() {
    return {"body": body};
  }
}
