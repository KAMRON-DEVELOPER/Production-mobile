import 'dart:async';
import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobile/models/note.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/models/users.dart';
import '../models/tab.dart';
import '../services/auth_api.dart';

class DataRepository {
  late AuthApiService authApiService;
  final Box<Users?> usersBox;
  final Box<User?> profileBox;
  final Box<MyTab?> tabsBox;
  final Box<Note?> notesBox;
  final Box settingsBox;
  Timer? _timer;

  DataRepository()
      : usersBox = Hive.box<Users>('usersBox'),
        profileBox = Hive.box<User>("profileBox"),
        tabsBox = Hive.box<MyTab>("tabsBox"),
        notesBox = Hive.box<Note>("notesBox"),
        settingsBox = Hive.box("settingsBox") {
    authApiService = AuthApiService();
    _startAutoCheckAuthentication();
  }

  // void _handleError(String functionName, dynamic e) {
  //   print("catch $functionName ** $e");
  // }

  // GETTERS
  Future<List<Users?>> getUsers() async {
    return usersBox.values.toList();
  }
  Future<User?> getProfile() async {
    return profileBox.get('profileData');
  }
  Future<List<Note?>> getNotes() async {
    return notesBox.values.toList();
  }
  Future<List<MyTab?>> getTabs() async {
    return tabsBox.values.toList();
  }
  Future<String?> getAccessToken() async =>
      await settingsBox.get("accessToken");
  Future<String?> getRefreshToken() async =>
      await settingsBox.get("refreshToken");
  Future<bool> getIsAuthenticated() async {
    try {
      return await _autoCheckAuthentication();
    } catch (e) {
      await setSettings("isAuthenticated", false);
      return false;
    }
  }

  Future<bool> getIsFetchedTabs() async {
      return await settingsBox.get("isFetchedTabs", defaultValue: false);
  }
  Future<bool> setIsFetchedTabs() async {
    try {
      await settingsBox.put("isFetchedTabs", true);
      return true;
    } catch (e) {
      print("catch setIsFetchedTabs ** $e");
      return false;
    }
  }
  Future<bool> getIsFetchedNotes() async {
    return await settingsBox.get("isFetchedNotes", defaultValue: false);
  }
  Future<bool> setIsFetchedNotes() async {
    try {
      await settingsBox.put("isFetchedNotes", true);
      return true;
    } catch (e) {
      print("catch setIsFetchedNotes ** $e");
      return false;
    }
  }

  // SETTERS
  setUsers(List<Users?> newUsers) async {
    print('setUsers users ** $newUsers');
    try {
      await usersBox.addAll(newUsers);
      return true;
    } catch (e) {
      print("catch setUsers ** $e");
      return false;
    }
  }
  clearUsers() async => await usersBox.clear();

  Future<bool> setProfile(User? newProfile) async {
    print('setProfile profile ** $newProfile');
    try {
      await profileBox.put("profileData", newProfile);
      return true;
    } catch (e) {
      print("catch setProfile ** $e");
      return false;
    }
  }
  Future<bool> updateProfile(User? updateData) async {
    print('updateProfile updateData ** $updateData');
    try {
      User? oldProfile = await getProfile();
      User? newProfile = oldProfile?.forUpdate(updateData);
      await setProfile(newProfile);
      return true;
    } catch (e) {
      print("catch updateProfile ** $e");
      return false;
    }
  }
  Future<bool> setNotes(List<Note?> newNotes) async {
    print('setNotes notes ** $newNotes');
    try {
      await notesBox.addAll(newNotes);
      return true;
    } catch (e) {
      print("catch setNotes ** $e");
      return false;
    }
  }
  Future<bool> updateNotes(int index, Note? updateData) async {
    print('updateNotes updateData ** $updateData');
    try {
      Note? oldNote = notesBox.getAt(index);
      final Note? newNote = oldNote?.forUpdate(updateData);
      await notesBox.putAt(index, newNote);
      return true;
    } catch (e) {
      print("catch setNotes ** $e");
      return false;
    }
  }
  Future<bool> addNote(Note? newNote) async {
    print('addNote newNote ** $newNote');
    try {
      await notesBox.add(newNote);
      return true;
    } catch (e) {
      print("catch addNote ** $e");
      return false;
    }
  }
  Future<bool> deleteNotes(int index) async {
    print('deleteNotes index ** $index');
    try {
      await notesBox.deleteAt(index);
      return true;
    } catch (e) {
      print("catch deleteNotes ** $e");
      return false;
    }
  }
  clearNotes() async => await notesBox.clear();

  Future<bool> setTabs(List<MyTab?> newTabs) async {
    print('setTabs tabs ** $newTabs');
    try {
      await tabsBox.clear();
      await tabsBox.addAll(newTabs);
      return true;
    } catch (e) {
      print("catch setTabs ** $e");
      return false;
    }
  }
  Future<bool> updateTabs(int index, MyTab? updateData) async {
    print('updateTabs updateData ** $updateData');
    try {
      MyTab? oldTab = tabsBox.getAt(index);
      MyTab? newTab = oldTab?.forUpdate(updateData);
      await tabsBox.putAt(index, newTab);
      return true;
    } catch (e) {
      print("catch updateTabs ** $e");
      return false;
    }
  }
  Future<bool> addTab(MyTab? newTab) async {
    print('addTab newTab ** $newTab');
    try {
      await tabsBox.add(newTab);
      return true;
    } catch (e) {
      print("catch addTab ** $e");
      return false;
    }
  }
  Future<bool> deleteTabs(int index) async {
    print('deleteTabs index ** $index');
    try {
      await tabsBox.deleteAt(index);
      return true;
    } catch (e) {
      print("catch deleteTabs ** $e");
      return false;
    }
  }
  clearTabs() async => await tabsBox.clear();

  Future<bool> setSettings(String key, dynamic value) async {
    print('setSettings key ** $key, value ** $value');
    try {
      await settingsBox.put(key, value);
      return true;
    } catch (e) {
      print("catch setSettings ** $e");
      return false;
    }
  }
  Future<bool> setSettingsAll(Map<String, dynamic> keysValues) async {
    print("setSettingsAll keysValues ** $keysValues");
    try {
      await settingsBox.putAll(keysValues);
      return true;
    } catch (e) {
      print("catch setSettingsAll ** $e");
      return false;
    }
  }

  // BACKGROUND TASKS
  Future<bool> _getIsExpiredAccess() async {
    String? token = await getAccessToken();
    return token == null ? true : JwtDecoder.isExpired(token);
  }
  Future<bool> _getIsExpiredRefresh() async {
    String? token = await getRefreshToken();
    return token == null ? true : JwtDecoder.isExpired(token);
  }

  Future<bool> _autoCheckAuthentication() async {
    bool isExpiredAccess = await _getIsExpiredAccess();
    bool isExpiredRefresh = await _getIsExpiredRefresh();
    User? user = await getProfile();
    String? username = user?.username;
    String? password = user?.password;
    print('_checkAndRefreshTokens isExpiredAccess >> $isExpiredAccess,'
        'isExpiredRefresh >> $isExpiredRefresh, username >> $username,'
        'password >> $password');

    if (!isExpiredAccess && !isExpiredRefresh) {
      await setSettings('isAuthenticated', true);
      return true;
    } else if (isExpiredAccess && !isExpiredRefresh) {
      try {
        String? refresh = await getRefreshToken();
        User? tokens =
        await authApiService.fetchAccessToken(refreshToken: refresh);
        print('_autoCheckAuthentication tokens ** $tokens');
        if (tokens != null) {
          await setSettingsAll(tokens.toMap());
          await setSettings('isAuthenticated', true);
          return true;
        } else {
          await setSettings('isAuthenticated', false);
          return false;
        }
      } catch (e) {
        print("catch _autoCheckAuthentication ** $e");
        return false;
      }
    } else if (isExpiredAccess &&
        isExpiredRefresh &&
        username != null &&
        password != null) {
      try {
        User? tokens = await authApiService.fetchRefreshToken(
          username: username,
          password: password,
        );
        print('_autoCheckAuthentication tokens >> $tokens');
        if (tokens != null) {
          await setSettingsAll(tokens.toMap());
          await setSettings('isAuthenticated', true);
          return true;
        } else {
          await setSettings('isAuthenticated', false);
          return false;
        }
      } catch (e) {
        print("catch _autoCheckAuthentication ** $e");
        return false;
      }
    } else {
      await setSettings('isAuthenticated', false);
      return false;
    }
  }
  void _startAutoCheckAuthentication() {
    _timer = Timer.periodic(const Duration(minutes: 10), (timer) async {
        try {
          print("_startAutoCheckAuthentication _autoCheckAuthentication");
          await _autoCheckAuthentication();
        } catch (e) {
          await setSettings('isAuthenticated', false);
        }
      },
    );
  }

  void dispose() {
    _timer?.cancel();
  }
}
