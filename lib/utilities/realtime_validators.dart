import 'package:hive/hive.dart';
import 'package:mobile/utilities/validator.dart';
import '../hive/users_model.dart';

final usersBox = Hive.box<UsersModel>('usersBox');

String? realtimeUsernameValidator(String value) {
  String? usernameErrorText;
  List<String?> usernames =
      usersBox.values.map((user) => user.username).toList();
  print('USERNAMES: $usernames');
  usernameErrorText = value.isValidName;
  if (usernameErrorText == null && usernames.contains(value)) {
    usernameErrorText = 'oops, the username is already exist';
  } else if (value.isEmpty) {
    usernameErrorText = 'please, fill the username field';
  }
  return usernameErrorText;
}

String? realtimePasswordValidator(String value) {
  String? passwordErrorText;
  passwordErrorText = value.isValidPassword;
  if (value.isEmpty) {
    passwordErrorText = 'please, fill the password field';
  }
  return passwordErrorText;
}

String? realtimeEmailOrPhoneValidator(String value) {
  String? emailOrPhoneErrorText;
  List<String?> emails = usersBox.values
      .map((user) => user.email)
      .where((email) => email != null)
      .toList();
  List<String?> phoneNumbers = usersBox.values
      .map((user) => user.phoneNumber)
      .where((phone) => phone != null)
      .toList();
  if (value.isEmpty) {
    emailOrPhoneErrorText = 'please, fill the field with email or phone number';
  } else if (value.startsWith('+')) {
    emailOrPhoneErrorText = value.isValidPhone;
    if (phoneNumbers.contains(value)) {
      emailOrPhoneErrorText = 'the phone number is already used';
    }
  } else if (RegExp(r'^[a-zA-Z0-9]').hasMatch(value)) {
    emailOrPhoneErrorText = value.isValidEmail;
    if (emails.contains(value)) {
      emailOrPhoneErrorText = 'the email is already used';
    }
  }
  return emailOrPhoneErrorText;
}
