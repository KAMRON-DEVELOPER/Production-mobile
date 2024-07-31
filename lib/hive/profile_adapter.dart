import 'package:hive/hive.dart';
import 'package:mobile/hive/profile_model.dart';

class ProfileAdapter extends TypeAdapter<ProfileModel> {
  @override
  final int typeId = 1;

  @override
  ProfileModel read(BinaryReader reader) {
    return ProfileModel(
      id: reader.readString(),
      username: reader.readString(),
      firstName: reader.readString(),
      lastName: reader.readString(),
      email: reader.readString(),
      phoneNumber: reader.readString(),
      fullName: reader.readString(),
      daysSinceJoined: reader.readInt(),
      photo: reader.readString(),
      dateOfBirth: reader.readString(),
      gender: reader.readString(),
      authType: reader.readString(),
      province: reader.readString(),
      bio: reader.readString(),
      dateJoined: reader.readString(),
      createdTime: reader.readString(),
      updatedTime: reader.readString(),
      tabs: _readTabs(reader),
    );
  }

// Helper method to read List<Map<String, String>> from BinaryReader
  List<Map<String, String>> _readTabs(BinaryReader reader) {
    final length = reader.readInt();
    final List<Map<String, String>> tabs = [];
    for (int i = 0; i < length; i++) {
      final Map<String, String> map = {};
      final mapLength = reader.readInt();
      for (int j = 0; j < mapLength; j++) {
        final key = reader.readString();
        final value = reader.readString();
        map[key] = value;
      }
      tabs.add(map);
    }
    return tabs;
  }

  @override
  void write(BinaryWriter writer, ProfileModel obj) {
    writer.writeString(obj.id ?? '');
    writer.writeString(obj.username ?? '');
    writer.writeString(obj.firstName ?? '');
    writer.writeString(obj.lastName ?? '');
    writer.writeString(obj.email ?? '');
    writer.writeString(obj.phoneNumber ?? '');
    writer.writeString(obj.fullName ?? '');
    writer.writeInt(obj.daysSinceJoined ?? 0);
    writer.writeString(obj.photo ?? '');
    writer.writeString(obj.dateOfBirth ?? '');
    writer.writeString(obj.gender ?? '');
    writer.writeString(obj.authType ?? '');
    writer.writeString(obj.province ?? '');
    writer.writeString(obj.bio ?? '');
    writer.writeString(obj.dateJoined ?? '');
    writer.writeString(obj.createdTime ?? '');
    writer.writeString(obj.updatedTime ?? '');
    _writeTabs(writer, obj.tabs ?? []);
  }

  // Helper method to write List<Map<String, String>> to BinaryWriter
  void _writeTabs(BinaryWriter writer, List<Map<String, String>> tabs) {
    writer.writeInt(tabs.length);
    for (var map in tabs) {
      writer.writeInt(map.length);
      for (var entry in map.entries) {
        writer.writeString(entry.key);
        writer.writeString(entry.value);
      }
    }
  }
}
