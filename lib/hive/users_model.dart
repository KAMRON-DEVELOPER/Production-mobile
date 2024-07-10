import 'package:hive/hive.dart';

class UsersModel extends HiveObject {
  @HiveField(0)
  String username;
  @HiveField(0)
  String? email;
  @HiveField(0)
  String? phoneNumber;

  UsersModel(
      {required this.username, this.email, this.phoneNumber});
}
