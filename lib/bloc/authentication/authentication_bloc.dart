import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/services/auth_api.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<RegisterEvent>(_onRegisterEvent);
    on<LoginEvent>(_onLoginEvent);
  }

  final AuthApiService authApiService = AuthApiService();

  void _onRegisterEvent(
      RegisterEvent event, Emitter<AuthenticationState> emit) async {
    print('_onRegisterEvent');
    emit(AuthenticationLoading());
    final user = User(
      username: event.username,
      password: event.password,
    ).toJsonForRegister(
      emailOrPhone: event.emailOrPhone,
    );
    print('USER: $user');
    final response = await authApiService.register(user as User);
    print('RESPONSE: $response');
    if (response != null) {
      emit(AuthenticationSuccess());
    } else {
      emit(const AuthenticationFailure('Registration Failed'));
    }
  }

  void _onLoginEvent(
      LoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final user = User(
      username: event.username,
      password: event.password,
    ).toJsonForRegister(
      emailOrPhone: event.code,
    );
    print('USER: $user');
    final response = await authApiService.login(user as User);
    print('RESPONSE: ${response?.accessToken}');
    if (response != null) {
      emit(AuthenticationSuccess());
    } else {
      emit(const AuthenticationFailure('Registration Failed'));
    }
  }
}
