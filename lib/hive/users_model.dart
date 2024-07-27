import 'package:hive/hive.dart';

class UsersModel extends HiveObject {
  @HiveField(0)
  String username;
  @HiveField(1)
  String? email;
  @HiveField(2)
  String? phoneNumber;

  UsersModel({required this.username, this.email, this.phoneNumber});
}
