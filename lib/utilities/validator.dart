extension Validator on String {
  String? get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegExp.hasMatch(this)) {
      return "email is invalid";
    }
    return null;
  }

  String? get isValidName {
    final nameRegExp = RegExp(r"^[A-Za-z][A-Za-z0-9_]{4,15}$");
    if (!nameRegExp.hasMatch(this)) {
      return "username is invalid";
    }
    return null;
  }

  String? get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?!.*(?:012|123|234|345|456|567|678|789|890))(?=.*[A-Za-z0-9]).{6,20}$');
    if (!passwordRegExp.hasMatch(this)) {
      return "password is invalid";
    }
    return null;
  }

  String? get isValidPhone {
    final phoneRegex = RegExp(r"^\+\d{1,3}\d{9,13}$");
    if (!phoneRegex.hasMatch(this)) {
      return "phone number is invalid";
    }
    return null;
  }
}
