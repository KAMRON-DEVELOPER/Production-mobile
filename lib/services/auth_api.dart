import 'package:dio/dio.dart';
import 'package:mobile/models/user.dart';

class AuthApiService {
  late Dio _dio;
  final String _baseUrl = 'http://192.168.31.42:8000/api/v1/';

  AuthApiService() {
    _dio = Dio();
  }

  Future<User?> fetchRegister({required User registerData}) async {
    try {
      Response response = await _dio.post(
        '${_baseUrl}users/register/',
        data: registerData.toJsonForRegister(),
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 201) {
        print('response in fetchRegister: ${response.data.toString()}');
        return User.fromJsonForToken(response.data);
      } else {
        print('Failed in fetchRegister: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error in fetchRegister: ${error.toString()}');
      return null;
    }
  }

  Future<User?> fetchVerify({required User verifyData, required String? accessToken}) async {
    try {
      Response response = await _dio.post(
        '${_baseUrl}users/verify/',
        data: verifyData.toJsonForVerify(),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      if (response.statusCode == 200) {
        print('response status code is 200 ok');
        return User.fromJsonForToken(response.data);
      } else {
        print('Failed in fetchVerify >> ${response.statusCode}');
        print('Failed in fetchVerify >> ${response.data.toString()}');
        return null;
      }
    } catch (error) {
      print('Error in fetchVerify >> ${error.toString()}');
      return null;
    }
  }

  Future<User?> fetchLogin({required User loginData}) async {
    try {
      Response response = await _dio.post(
        '${_baseUrl}users/login/',
        data: loginData.toJsonForLogin(),
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200) {
        print('response in fetchLogin: ${response.data.toString()}');
        return User.fromJsonForToken(response.data);
      } else {
        print('Failed in fetchLogin: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error in fetchLogin: ${error.toString()}');
      return null;
    }
  }

  Future<User?> fetchUserProfile({required String? accessToken}) async {
    try {
      Response response = await _dio.get(
        '${_baseUrl}users/profile/',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      if (response.statusCode == 200) {
        print('response in fetchUserProfile: ${response.data.toString()}');
        return User.fromJson(response.data);
      } else {
        print('Failed in fetchUserProfile: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error in fetchUserProfile: ${error.toString()}');
      return null;
    }
  }

  Future<bool> fetchUpdateUserProfile({required String? accessToken, required User? updateData}) async {
    try {
      Response response = await _dio.put(
        '${_baseUrl}users/profile/',
        data: updateData,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      if (response.statusCode == 200) {
        print('response in fetchUpdateUserProfile: ${response.statusCode}');
        return true;
      } else {
        print('failed in fetchUserProfile: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('error in fetchUserProfile: ${e.toString()}');
      return false;
    }
  }

  Future<User?> fetchAccessToken({required String? refreshToken}) async {
    try {
      Response response = await _dio.post(
        '${_baseUrl}users/token/refresh/',
        data: {"refresh": refreshToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        print('response in fetchToken: ${response.data.toString()}');
        return User.fromJsonForToken(response.data);
      } else {
        print('Failed in fetchToken: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error in fetchToken: ${error.toString()}');
      return null;
    }
  }

  Future<User?> fetchRefreshToken(
      {required String? username, required String? password}) async {
    try {
      Response response = await _dio.post(
        '${_baseUrl}users/token/',
        data: {"username": username, "password": password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        print('response in fetchRefreshToken: ${response.data.toString()}');
        return User.fromJsonForToken(response.data);
      } else {
        print('Failed in fetchRefreshToken: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error in fetchRefreshToken: ${error.toString()}');
      return null;
    }
  }
}
