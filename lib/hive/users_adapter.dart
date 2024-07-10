import 'package:hive/hive.dart';
import 'package:mobile/hive/users_model.dart';

class UsersAdapter extends TypeAdapter<UsersModel> {
  @override
  final int typeId = 0;

  @override
  UsersModel read(BinaryReader reader) {
    final username = reader.read();
    final String? email = reader.read();
    final String? phoneNumber = reader.read();

    return UsersModel(username: username, email: email, phoneNumber: phoneNumber);
  }

  @override
  void write(BinaryWriter writer, UsersModel obj) {
    writer.write(obj.username);
    writer.write(obj.email);
    writer.write(obj.phoneNumber);
  }
}
