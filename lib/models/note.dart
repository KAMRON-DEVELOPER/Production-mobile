class Note {
  String? id;
  String? body;
  bool? isPinned;
  int? sequenceNumber;
  String? category;
  String? createdTime;
  String? updatedTime;

  Note({
    this.id,
    this.body,
    this.isPinned,
    this.sequenceNumber,
    this.category,
    this.createdTime,
    this.updatedTime,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      body: json['body'],
      isPinned: json['isPinned'],
      sequenceNumber: json['sequence_number'],
      category: json['category'],
      createdTime: json['created_time'],
      updatedTime: json['updated_time'],
    );
  }

  Map<String, String?> toJson() {
    return {"body": body};
  }
}
