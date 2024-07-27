import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:mobile/models/user.dart';

class AuthApiService {
  late final Dio _dio = Dio();
  final String _baseUrl = 'http://192.168.31.42:8000/api/v1/';
  final settingsBox = Hive.box('settingsBox');

  Future<User?> fetchRegister({required User registerData}) async {
    try {
      Response response = await _dio.post(
        '${_baseUrl}users/register/',
        data: registerData.toJsonForRegister(),
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 201) {
        print('response in fetchRegister: ${response.data.toString()}');
        return User.fromJsonToToken(response.data);
      } else {
        print('Failed in fetchRegister: ${response.statusCode}');
        throw Exception('Failed in fetchRegister: ${response.data.toString()}');
      }
    } catch (error) {
      print('Error in fetchRegister: ${error.toString()}');
      throw Exception('An unknown error occurred: ${error.toString()}');
    }
  }

  Future<User?> fetchVerify(
      {required User verifyData, required String accessToken}) async {
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
        return User.fromJsonToToken(response.data);
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
        return User.fromJsonToToken(response.data);
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

  Future<User?> fetchToken({required String? refreshToken}) async {
    try {
      Response response = await _dio.post(
        '${_baseUrl}users/token/refresh/',
        data: {"refresh": refreshToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        print('response in fetchToken: ${response.data.toString()}');
        return User.fromJsonToToken(response.data);
      } else {
        print('Failed in fetchToken: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error in fetchToken: ${error.toString()}');
      return null;
    }
  }
}
