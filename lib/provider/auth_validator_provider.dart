import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobile/utilities/validator.dart';
import '../hive/users_model.dart';

class AuthValidatorProvider extends ChangeNotifier {
  String? usernameErrorText;
  String? emailOrPhoneErrorText;
  String? passwordErrorText;
  final usersBox = Hive.box<UsersModel>('usersBox');

  Map? validateField(Map authData) {
    String username = authData['username'];
    String emailOrPhone = authData['emailOrPassword'];
    String password = authData['password'];

    usernameErrorText = username.isValidName;
    emailOrPhoneErrorText = emailOrPhone.isValidEmailOrPhone;
    passwordErrorText = password.isValidPassword;

    ChangeNotifier();
    return {
      usernameErrorText: usernameErrorText,
      emailOrPhoneErrorText: emailOrPhoneErrorText,
      passwordErrorText: passwordErrorText,
    };
  }
}
