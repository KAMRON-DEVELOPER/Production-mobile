import 'package:hive/hive.dart';

import '../models/user.dart';

class ProfileModel extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? username;
  @HiveField(2)
  String? firstName;
  @HiveField(3)
  String? lastName;
  @HiveField(4)
  String? email;
  @HiveField(5)
  String? phoneNumber;
  @HiveField(6)
  String? fullName;
  @HiveField(7)
  int? daysSinceJoined;
  @HiveField(8)
  String? photo;
  @HiveField(9)
  String? dateOfBirth;
  @HiveField(10)
  String? gender;
  @HiveField(11)
  String? authType;
  @HiveField(12)
  String? province;
  @HiveField(13)
  String? bio;
  @HiveField(14)
  String? dateJoined;
  @HiveField(15)
  String? createdTime;
  @HiveField(16)
  String? updatedTime;

  ProfileModel({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.fullName,
    required this.daysSinceJoined,
    required this.photo,
    required this.dateOfBirth,
    required this.gender,
    required this.authType,
    required this.province,
    required this.bio,
    required this.dateJoined,
    required this.createdTime,
    required this.updatedTime,
  });

  factory ProfileModel.fromUserModel(User user) {
    return ProfileModel(
      id: user.id,
      username: user.username,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      phoneNumber: user.phoneNumber,
      fullName: user.fullName,
      daysSinceJoined: user.daysSinceJoined,
      photo: user.photo,
      dateOfBirth: user.dateOfBirth,
      gender: user.gender,
      authType: user.authType,
      province: user.province,
      bio: user.bio,
      dateJoined: user.dateJoined,
      createdTime: user.createdTime,
      updatedTime: user.updatedTime,
    );
  }
}
