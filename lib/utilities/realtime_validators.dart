import 'package:hive/hive.dart';
import 'package:mobile/utilities/validator.dart';
import '../hive/users_model.dart';

final usersBox = Hive.box<UsersModel>('usersBox');
final emails = usersBox.values
    .where((user) => user.email != null)
    .map((user) => user.email)
    .toList();
final phoneNumbers = usersBox.values
    .where((user) => user.phoneNumber != null)
    .map((user) => user.phoneNumber)
    .toList();

String? registerUsernameValidator(String value) {
  return usersBox.values.any((user) => user.username == value)
      ? 'Oops, the username is already in use'
      : value.isValidName;
}

String? loginUsernameValidator(String value) {
  usersBox.values.map((user) => print("user.username: ${user.username}"));
  return usersBox.values.any((user) => user.username == value)
      ? value.isValidName
      : 'Username not found';
}

String? realtimePasswordValidator(String value) {
  return value.isValidPassword;
}

String? realtimeEmailOrPhoneValidator(String value) {
  if (value.startsWith('+') && phoneNumbers.contains(value)) {
    return "Oops, this phone number is already in use";
  } else if (value.startsWith(RegExp(r'^[a-zA-Z0-9]')) &&
      emails.contains(value)) {
    return "Oops, this email is already in use";
  }
  return value.isValidEmailOrPhone;
}

String? realtimeCodeValidator(String value) {
  return value.isValidCode;
}
