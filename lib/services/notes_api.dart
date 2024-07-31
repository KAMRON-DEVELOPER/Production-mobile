import 'package:dio/dio.dart';
import 'package:mobile/models/note.dart';

class NoteApiService {
  late Dio _dio;
  late String accessToken;
  final String _baseUrl = 'http://192.168.31.42:8000/api/v1/';

  NoteApiService() {
    _dio = Dio();
  }

  Future<List<Note?>> fetchNotes({required String? accessToken}) async {
    try {
      Response response = await _dio.get(
        '${_baseUrl}users/notes/',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      if (response.statusCode == 200) {
        print('response in fetchNotes: ${response.data}');
        List<dynamic> data = response.data;
        return data.map((noteJson) => Note.fromJson(noteJson)).toList();
      } else {
        print('Failed in fetchNotes: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error in fetchNotes: ${error.toString()}');
      return [];
    }
  }

  Future<List<Note?>?> fetchCreateNote(Note note) async {
    try {
      Response response =
          await _dio.post('${_baseUrl}users/notes/', data: note.toJson());
      print("1) response.data.toString() : ${response.data.toString()}");
      if (response.statusCode == 201) {
        return [];
      } else {
        print("ERRRRRRRRRORRRR");
        return null;
      }
    } catch (e) {
      print('ERRRRRRRRRORRRR: $e');
      return null;
    }
  }

  Future<List<Note?>?> fetchUpdateNote(Note note) async {
    try {
      Response response =
          await _dio.put('${_baseUrl}users/notes/', data: note.toJson());
      print("1) response.data.toString() : ${response.data.toString()}");
      if (response.statusCode == 201) {
        return [];
      } else {
        print("ERRRRRRRRRORRRR");
        return null;
      }
    } catch (e) {
      print('ERRRRRRRRRORRRR: $e');
      return null;
    }
  }

  Future<List<Note?>?> fetchDeleteNote(String id) async {
    try {
      Response response =
          await _dio.post('${_baseUrl}users/notes/', data: {"id": id});
      print("1) response.statusCode : ${response.statusCode}");
      if (response.statusCode == 204) {
        return [];
      } else {
        print("Note delete had not fetched");
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
