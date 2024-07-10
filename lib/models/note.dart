import 'package:mobile/models/user.dart';

class Note {
  String? id;
  User? owner;
  String? text;
  bool? isPinned;
  int? sequenceNumber;
  String? category;
  String? createdTime;
  String? updatedTime;

  Note(
      {this.id,
      this.owner,
      this.text,
      this.isPinned,
      this.sequenceNumber,
      this.category,
      this.createdTime,
      this.updatedTime});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      owner: json['owner'] != null ? User.fromJson(json['owner']) : null,
      text: json['text'],
      isPinned: json['isPinned'],
      sequenceNumber: json['sequence_number'],
      category: json['category'],
      createdTime: json['created_time'],
      updatedTime: json['updated_time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}
