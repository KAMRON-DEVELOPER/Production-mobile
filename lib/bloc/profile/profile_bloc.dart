import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobile/bloc/profile/profile_event.dart';
import 'package:mobile/bloc/profile/profile_state.dart';
import 'package:mobile/hive/profile_model.dart';
import 'package:mobile/services/auth_api.dart';
import '../../models/user.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileStateLoading()) {
    on<GetProfileEvent>(_getAPIProfileEvent);
    on<GetCacheProfileEvent>(_getCacheProfileEvent);
  }

  final AuthApiService authApiService = AuthApiService();
  final settingsBox = Hive.box('settingsBox');
  final profileBox = Hive.box<ProfileModel>('profileBox');

  void _getCacheProfileEvent(ProfileEvent event, Emitter<ProfileState> emit) {
    final ProfileModel? profileData = profileBox.get('profileData');
    if (profileData != null) {
      final User user = User.fromProfileModel(profileData);
      emit(ProfileStateSuccess(profileData: user));
    } else {
      emit(const ProfileStateFailure(
          profileFailureMessage: 'No profile data available offline'));
    }
  }

  void _getAPIProfileEvent(
      ProfileEvent event, Emitter<ProfileState> emit) async {
    String? accessToken = await settingsBox.get('accessToken');
    String? refreshToken = await settingsBox.get('refreshToken');
    bool isAuthenticated =
        await settingsBox.get('isAuthenticated', defaultValue: false);
    print(
        '1) accessToken >>>> $accessToken, refreshToken >> $refreshToken, isAuthenticated >>>> $isAuthenticated');

    bool hasExpiredAccessToken = true;
    bool hasExpiredRefreshToken = true;
    if (accessToken != null && refreshToken != null) {
      hasExpiredAccessToken = JwtDecoder.isExpired(accessToken);
      hasExpiredRefreshToken = JwtDecoder.isExpired(refreshToken);
    }
    print('2) hasExpiredAccessToken >>>> $hasExpiredAccessToken');

    if (!isAuthenticated ||
        hasExpiredRefreshToken ||
        accessToken == null && refreshToken == null) {
      print('3) isAuthenticated >>>> false');
      emit(
        const ProfileStateFailure(
            profileFailureMessage: "you need to register or login???"),
      );
    } else if (hasExpiredAccessToken && !hasExpiredRefreshToken) {
      print(
          '3) hasExpiredAccessToken >>>> true, hasExpiredRefreshToken >>>> false');
      final User? tokens =
          await authApiService.fetchToken(refreshToken: refreshToken);
      print('4) tokens >>>> $tokens');
      if (tokens != null) {
        await settingsBox.putAll({
          "accessToken": tokens.accessToken,
          "refreshToken": tokens.refreshToken,
        });
        emit(const ProfileStateLoading(mustRebuild: true));
      } else {
        emit(
          const ProfileStateFailure(
              profileFailureMessage: "token fetching failed???"),
        );
      }
    } else if (isAuthenticated) {
      print('3) isAuthenticated >>>> true');
      final User? user =
          await authApiService.fetchUserProfile(accessToken: accessToken);
      print('4) profileData >>>> ${user?.username}');
      if (user != null) {
        await profileBox.put('profileData', ProfileModel.fromUserModel(user));
        emit(ProfileStateSuccess(profileData: user));
      } else {
        emit(
          const ProfileStateFailure(
              profileFailureMessage: 'Load profile data failed???'),
        );
      }
    }
  }
}
