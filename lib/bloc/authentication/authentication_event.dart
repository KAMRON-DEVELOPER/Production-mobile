import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class RegisterEvent extends AuthenticationEvent {
  final String username;
  final String emailOrPhone;
  final String password;

  const RegisterEvent({
    required this.username,
    required this.emailOrPhone,
    required this.password,
  });

  @override
  List<Object> get props => [username, emailOrPhone, password];
}

class LoginEvent extends AuthenticationEvent {
  final String username;
  final String password;
  final String code;

  const LoginEvent({
    required this.username,
    required this.password,
    required this.code,
  });

  @override
  List<Object> get props => [username, password, code];
}
