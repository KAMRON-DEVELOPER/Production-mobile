import 'package:hive/hive.dart';
import 'package:mobile/models/user.dart';

class ProfileAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    return User(
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
      province: reader.readString(),
      bio: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
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
    writer.writeString(obj.province ?? '');
    writer.writeString(obj.bio ?? '');
  }
}
