import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:mobile/hive/users_model.dart';

class ValidateApiService {
  late final Dio _dio = Dio();
  final usersBox = Hive.box<UsersModel>('usersBox');
  final String _baseUrl = 'http://192.168.31.42:8000/api/v1/users/';

  ValidateApiService() {
    fetchAndStoreUserData();
  }

  Future<void> fetchAndStoreUserData() async {
    await usersBox.clear();
    print('1) USERS: ${usersBox.values}');
    try {
      Response response = await _dio.get(_baseUrl);
      print('RESPONSE.DATA: ${response.data}');
      print('RESPONSE.DATA:TYPE: ${response.data.runtimeType}');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        for (var user in data) {
          await usersBox.add(
            UsersModel(username: user['username'], email: user['email'], phoneNumber: user['phone_number']),
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
