import 'package:hive/hive.dart';

class UsersModel extends HiveObject {
  @HiveField(0)
  String username;
  @HiveField(0)
  String email;

  UsersModel({required this.username, required this.email});
}
