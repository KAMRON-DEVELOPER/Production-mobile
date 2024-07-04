import 'package:hive/hive.dart';
import 'package:mobile/hive/users_model.dart';

class UsersAdapter extends TypeAdapter<UsersModel> {
  @override
  final int typeId = 0;

  @override
  UsersModel read(BinaryReader reader) {
    final username = reader.read() as String;
    final email = reader.read() as String;

    return UsersModel(username: username, email: email);
  }

  @override
  void write(BinaryWriter writer, UsersModel obj) {
    writer.write(obj.username);
    writer.write(obj.email);
  }
}
