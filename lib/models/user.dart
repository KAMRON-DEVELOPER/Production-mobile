import '../hive/profile_model.dart';

class User {
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? password;
  String? fullName;
  int? daysSinceJoined;
  String? photo;
  String? dateOfBirth;
  String? gender;
  String? authType;
  String? province;
  String? bio;
  String? dateJoined;
  String? createdTime;
  String? updatedTime;
  String? accessToken;
  String? refreshToken;
  String? emailOrPhone;
  String? code;

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
    this.authType,
    this.province,
    this.bio,
    this.dateJoined,
    this.createdTime,
    this.updatedTime,
    this.accessToken,
    this.refreshToken,
    this.password,
    this.emailOrPhone,
    this.code,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['full_name'] = fullName;
    data['days_since_joined'] = daysSinceJoined;
    data['photo'] = photo;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['auth_type'] = authType;
    data['province'] = province;
    data['bio'] = bio;
    data['date_joined'] = dateJoined;
    data['created_time'] = createdTime;
    data['updated_time'] = updatedTime;
    return data;
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
      authType: json['auth_type'],
      province: json['province'],
      bio: json['bio'],
      dateJoined: json['date_joined'],
      createdTime: json['created_time'],
      updatedTime: json['updated_time'],
      accessToken: json['access'],
      refreshToken: json['refresh'],
    );
  }

  factory User.fromJsonToToken(Map<String, dynamic> json) {
    return User(
      accessToken: json['access'],
      refreshToken: json['refresh'],
    );
  }

  factory User.fromProfileModel(ProfileModel profileModel) {
    return User(
      id: profileModel.id,
      username: profileModel.username,
      firstName: profileModel.firstName,
      lastName: profileModel.lastName,
      email: profileModel.email,
      phoneNumber: profileModel.phoneNumber,
      fullName: profileModel.fullName,
      daysSinceJoined: profileModel.daysSinceJoined,
      photo: profileModel.photo,
      dateOfBirth: profileModel.dateOfBirth,
      gender: profileModel.gender,
      authType: profileModel.authType,
      province: profileModel.province,
      bio: profileModel.bio,
      dateJoined: profileModel.dateJoined,
      createdTime: profileModel.createdTime,
      updatedTime: profileModel.updatedTime,
    );
  }
}
