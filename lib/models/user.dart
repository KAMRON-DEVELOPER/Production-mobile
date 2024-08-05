import 'package:hive/hive.dart';

class User extends HiveObject {
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
  String? password;
  @HiveField(7)
  String? fullName;
  @HiveField(8)
  int? daysSinceJoined;
  @HiveField(9)
  String? photo;
  @HiveField(10)
  String? dateOfBirth;
  @HiveField(11)
  String? gender;
  @HiveField(12)
  String? authType;
  @HiveField(13)
  String? province;
  @HiveField(14)
  String? bio;
  @HiveField(15)
  String? code;
  @HiveField(16)
  String? emailOrPhone;
  @HiveField(17)
  String? accessToken;
  @HiveField(18)
  String? refreshToken;

  User({
    this.id,
    this.username,
    this.fullName,
    this.daysSinceJoined,
    this.photo,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.province,
    this.bio,
    this.password,
    this.code,
    this.emailOrPhone,
    this.accessToken,
    this.refreshToken,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "photo": photo,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "phone_number": phoneNumber,
      "date_of_birth": dateOfBirth,
      "gender": gender,
      "province": province,
      "bio": bio,
    };
  }

  Map<String, dynamic> toJsonForRegister() {
    return {
      'username': username,
      'email_or_phone': emailOrPhone,
      'password': password,
    };
  }

  Map<String, dynamic> toJsonForVerify() {
    return {'code': code};
  }

  Map<String, dynamic> toJsonForLogin() {
    return {'username': username, 'password': password};
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      fullName: json['full_name'],
      daysSinceJoined: json['days_since_joined'],
      photo: json['photo'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      province: json['province'],
      bio: json['bio'],
      accessToken: json['access'],
      refreshToken: json['refresh'],
    );
  }

  factory User.fromJsonForToken(Map<String, dynamic> json) {
    return User(
      accessToken: json['access'],
      refreshToken: json['refresh'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "accessToken": accessToken,
      "refreshToken": refreshToken,
    };
  }

  forUpdate(User? updateData) {
    return User(
      username: updateData?.username ?? username,
      fullName: updateData?.fullName ?? fullName,
      daysSinceJoined: daysSinceJoined,
      photo: updateData?.photo ?? photo,
      firstName: updateData?.firstName ?? firstName,
      lastName: updateData?.lastName ?? lastName,
      email: updateData?.email ?? email,
      phoneNumber: updateData?.phoneNumber ?? phoneNumber,
      dateOfBirth: updateData?.dateOfBirth ?? dateOfBirth,
      gender: updateData?.gender ?? gender,
      province: updateData?.province ?? province,
      bio: updateData?.bio ?? bio,
    );
  }
}
