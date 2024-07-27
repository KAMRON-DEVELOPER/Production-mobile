import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/services/auth_api.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthApiService _authApiService = AuthApiService();
  final settingsBox = Hive.box('settingsBox');

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<RegisterSubmitEvent>(_registerSubmitEvent);
    on<VerifySubmitEvent>(_verifySubmitEvent);
    on<LoginSubmitEvent>(_loginSubmitEvent);
  }

  void _registerSubmitEvent(
      RegisterSubmitEvent event, Emitter<AuthenticationState> emit) async {
    print('_registerSubmitEvent');
    emit(AuthenticationLoading());
    try {
      final User? registerSuccessData =
          await _authApiService.fetchRegister(registerData: event.registerData);
      if (registerSuccessData != null) {
        await settingsBox.putAll({
          "accessToken": registerSuccessData.accessToken,
          "refreshToken": registerSuccessData.refreshToken,
        });
        emit(AuthenticationSuccess(registerSuccessData: registerSuccessData));
      } else {
        emit(
          const AuthenticationFailure(
              registerFailureMessage: 'Register failed'),
        );
      }
    } catch (error) {
      emit(
        const AuthenticationFailure(
            registerFailureMessage:
                'An unknown error occurred while registering'),
      );
    }
  }

  void _verifySubmitEvent(
      VerifySubmitEvent event, Emitter<AuthenticationState> emit) async {
    print('_registerSubmitEvent');
    emit(AuthenticationLoading());
    String accessToken = await settingsBox.get('accessToken');
    try {
      final User? verifySuccessData = await _authApiService.fetchVerify(
        verifyData: event.verifyData,
        accessToken: accessToken,
      );
      if (verifySuccessData != null) {
        await settingsBox.putAll({
          "accessToken": verifySuccessData.accessToken,
          "refreshToken": verifySuccessData.refreshToken,
          "isAuthenticated": true,
        });
        emit(AuthenticationSuccess(registerSuccessData: verifySuccessData));
      } else {
        emit(
          const AuthenticationFailure(
              registerFailureMessage: 'Verification failed'),
        );
      }
    } catch (error) {
      emit(
        const AuthenticationFailure(
            registerFailureMessage:
                'An unknown error occurred while registering'),
      );
    }
  }

  void _loginSubmitEvent(
      LoginSubmitEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final User? loginSuccessData =
          await _authApiService.fetchLogin(loginData: event.loginData);
      if (loginSuccessData != null) {
        await settingsBox.putAll({
          "accessToken": loginSuccessData.accessToken,
          "refreshToken": loginSuccessData.refreshToken,
          "isAuthenticated": true,
        });
        emit(AuthenticationSuccess(loginSuccessData: loginSuccessData));
      } else {
        emit(const AuthenticationFailure(loginFailureMessage: 'Login failed'));
      }
    } catch (error) {
      emit(
        const AuthenticationFailure(
            loginFailureMessage: 'An unknown error occurred while logging'),
      );
    }
  }
}

// final profileBox = Hive.box<ProfileModel>('profileBox');

// await profileBox.put('profileData', ProfileModel(
//     id: verifySuccessData.id,
//     username: verifySuccessData.username,
//     firstName: verifySuccessData.firstName,
//     lastName: verifySuccessData.lastName,
//     email: verifySuccessData.email,
//     phoneNumber: verifySuccessData.phoneNumber,
//     fullName: verifySuccessData.fullName,
//     daysSinceJoined: verifySuccessData.daysSinceJoined,
//     photo: verifySuccessData.photo,
//     dateOfBirth: verifySuccessData.dateOfBirth,
//     gender: verifySuccessData.gender,
//     authType: verifySuccessData.authType,
//     province: verifySuccessData.province,
//     bio: verifySuccessData.bio,
//     dateJoined: verifySuccessData.dateJoined,
//     createdTime: verifySuccessData.createdTime,
//     updatedTime: verifySuccessData.updatedTime,
//   ),);
