import 'package:dio/dio.dart';
import 'package:mobile/provider/data_provider.dart';

import '../models/users.dart';

class ValidateApiService {
  late Dio _dio;
  late DataRepository dataRepository;
  final String _baseUrl = 'http://192.168.31.42:8000/api/v1/users/';

  ValidateApiService() {
    _dio = Dio();
    dataRepository = DataRepository();
    fetchAndStoreUserData();
  }

  Future<void> fetchAndStoreUserData() async {
    try {
      Response response = await _dio.get(_baseUrl);
      print('RESPONSE IN fetchAndStoreUserData: ${response.data}');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        List<Users?> users = data.map((user) => Users.toUsers(user)).toList();
        await dataRepository.clearUsers();
        await dataRepository.setUsers(users);
      } else {
        print('ERROR IN fetchAndStoreUserData');
      }
    } catch (e) {
      print("ERROR IN fetchAndStoreUserData: $e");
    }
  }
}
