import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobile/bloc/notes/notes_event.dart';
import 'package:mobile/bloc/notes/notes_state.dart';
import 'package:mobile/hive/note_model.dart';
import 'package:mobile/hive/profile_model.dart';
import 'package:mobile/services/notes_api.dart';

import '../../models/note.dart';
import '../../models/user.dart';
import '../../services/auth_api.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(const NotesStateLoading()) {
    on<GetNotesEvent>(_getNotesEvent);
    on<GetCacheNotesEvent>(_getCacheNotesEvent);
  }

  final NoteApiService noteApiService = NoteApiService();
  final AuthApiService authApiService = AuthApiService();
  final notesBox = Hive.box<NoteModel>('notesBox');
  final settingsBox = Hive.box('settingsBox');
  final profileBox = Hive.box<ProfileModel>('profileBox');

  Future<void> _getCacheNotesEvent(
      NotesEvent event, Emitter<NotesState> emit) async {}

  void _getNotesEvent(NotesEvent event, Emitter<NotesState> emit) async {
    String? accessToken = await settingsBox.get('accessToken');
    String? refreshToken = await settingsBox.get('refreshToken');
    bool isAuthenticated =
        await settingsBox.get('isAuthenticated', defaultValue: false);
    print(
        'access >>>> $accessToken, refresh >> $refreshToken, isAuthenticated >>>> $isAuthenticated');

    bool hasExpiredAccessToken = true;
    bool hasExpiredRefreshToken = true;
    if (accessToken != null && refreshToken != null) {
      hasExpiredAccessToken = JwtDecoder.isExpired(accessToken);
      hasExpiredRefreshToken = JwtDecoder.isExpired(refreshToken);
    }
    print('hasExpiredAccessToken >>>> $hasExpiredAccessToken');

    if (!isAuthenticated ||
        hasExpiredRefreshToken ||
        accessToken == null && refreshToken == null) {
      print('3) isAuthenticated >>>> false');
      emit(const NotesStateFailure(
          notesFailureMessage: "you are not authenticated"));
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
        emit(const NotesStateLoading(mustRebuild: true));
      } else {
        emit(
          const NotesStateFailure(
              notesFailureMessage: "token fetching failed???"),
        );
      }
    } else if (isAuthenticated) {
      print('3) isAuthenticated >>>> true');
      final List<Note?> notes =
          await noteApiService.fetchNotes(accessToken: accessToken);
      print('profileData >>>> ${notes.first?.body}');
      if (notes != []) {
        notes.map((note) async =>
            await notesBox.put('notesData', NoteModel.fromNote(note!)));
        emit(NotesStateSuccess(notesData: notes as List<Map<String, dynamic>>));
      } else {
        emit(
          const NotesStateFailure(
              notesFailureMessage: 'Load notes data failed???'),
        );
      }
    }
  }
}
