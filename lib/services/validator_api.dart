import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:mobile/hive/users_model.dart';

class ValidateApiService {
  late Dio _dio;
  final String _baseUrl = 'http://192.168.31.42:8000/api/';
  final usersBox = Hive.box<UsersModel>('usersBox');

  ValidateApiService() {
    _dio = Dio();
  }

  //! getAllUserData && store
  Future<void> fetchAndStoreUserData() async {
    await usersBox.clear();
    print('1) USERS: ${usersBox.values}');
    try {
      Response response =
          await _dio.get('${_baseUrl}users/get_all_users_data/');
      print('RESPONSE.DATA: ${response.data}');
      print('RESPONSE.DATA:TYPE: ${response.data.runtimeType}');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        for (var user in data) {
          await usersBox.add(
            UsersModel(username: user['username'], email: user['email']),
          );
        }
      } else {
        print('ERROR FETCHING USERS DATA');
      }
    } catch (e) {
      print("ERROR FETCHING USERS DATA: $e");
    }
  }
}
