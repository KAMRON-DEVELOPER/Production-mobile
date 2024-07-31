import 'package:hive/hive.dart';
import 'package:mobile/hive/note_model.dart';

class NoteAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 2;

  @override
  NoteModel read(BinaryReader reader) {
    return NoteModel(
      id: reader.readString(),
      body: reader.readString(),
      category: reader.readString(),
      isPinned: reader.readBool(),
      sequenceNumber: reader.readInt(),
      createdTime: reader.readString(),
      updatedTime: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer.writeString(obj.id ?? '');
    writer.writeString(obj.body ?? '');
    writer.writeString(obj.category ?? '');
    writer.writeBool(obj.isPinned ?? false);
    writer.writeInt(obj.sequenceNumber ?? 0);
    writer.writeString(obj.createdTime ?? '');
    writer.writeString(obj.updatedTime ?? '');
  }
}
