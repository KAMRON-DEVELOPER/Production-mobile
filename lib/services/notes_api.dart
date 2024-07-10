import 'package:dio/dio.dart';
import 'package:mobile/models/note.dart';

class NoteApiService {
  late Dio _dio;
  late String accessToken;
  final String _baseUrl = 'http://192.168.31.42:8000/api/v1/';

  NoteApiService() {
    _dio = Dio();
    // accessToken = Hive.box('settingsBox').get('accessToken');
    // print("accessToken: $accessToken");
  }

  //! notes fetcher
  Future<List<Note?>> getNotes() async {
    try {
      Response response = await _dio.get('${_baseUrl}users/notes/');
      print("1) response.data.toString() : ${response.data.toString()}");
      return response.data;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Note?>> createNote(Note note) async {
    try {
      Response response =
          await _dio.post('${_baseUrl}users/login/', data: note.toJson());
      print("1) response.data.toString() : ${response.data.toString()}");
      if (response.statusCode == 201) {
        List<dynamic> jsonNotesList = response.data;
        List<Note> notes =
            jsonNotesList.map((json) => Note.fromJson(json)).toList();
        return notes;
      } else {
        print("Note delete had not fetched");
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  //! delete fetcher
  Future<List<Note?>> deleteNote(String id) async {
    try {
      Response response =
          await _dio.post('${_baseUrl}users/login/', data: {"id": id});
      print("1) response.data.toString() : ${response.data.toString()}");
      if (response.statusCode == 200) {
        List<dynamic> jsonNotesList = response.data;
        List<Note> notes =
            jsonNotesList.map((json) => Note.fromJson(json)).toList();
        return notes;
      } else {
        print("Note delete had not fetched");
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
