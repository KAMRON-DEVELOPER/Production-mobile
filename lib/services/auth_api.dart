import 'package:dio/dio.dart';
import 'package:mobile/models/user.dart';

class AuthApiService {
  late Dio _dio;
  final String _baseUrl = 'http://192.168.31.42:8000/api/';
  // final settingsBox = Hive.box('settingsBox');

  AuthApiService() {
    _dio = Dio();
  }

  //! register fetcher
  Future<User?> register(User registerData) async {
    try {
      Response response = await _dio.post(
        '${_baseUrl}users/register/',
        data: registerData,
      );
      print("response.data.toString() : ${response.data.toString()}");
      if (response.statusCode == 201) {
        var user = User.fromJsonForRegister(response.data);
        return user;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  //! login fetcher
  Future<User?> login(User loginData) async {
    Response response = await _dio.post(
      '${_baseUrl}users/login/',
      data: loginData,
    );
    print("response.data.toString(): ${response.data.toString()}");
    if (response.statusCode == 200) {
      try {
        // settingsBox.put('accessToken', response.data['access_token']);
        print('ACCESS AND REFRESH SAVED!!!');
      } catch (e) {
        print('ACCESS_TOKEN ERROR: $e');
      }
    }
    return User.fromJsonForLogin(response.data);
  }

  //! get user profile
  Future<User?> getUserProfile(String accessToken) async {
    try {
      Response response = await _dio.get(
        '${_baseUrl}user/',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      print(response.data.toString());
      return User.fromJson(response.data);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
