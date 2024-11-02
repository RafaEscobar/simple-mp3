import 'dart:convert';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_mp3/models/song.dart';

class PreferencesService {
  static late SharedPreferences pref;

  static Future<void> init() async => pref = await SharedPreferences.getInstance();

  static set storagePermissionResponse(PermissionStatus newValue) => pref.setInt('storagePermissionResponse', newValue.index);
  static PermissionStatus get storagePermissionResponse{
    int indexValue = pref.getInt('storagePermissionResponse') ?? 0;
    return PermissionStatus.values[indexValue];
  }

  static String get currentSong =>  pref.getString('currentSong') ?? '';
  static void setCurrentSong(Song newValue) {
    String userJson = jsonEncode(newValue.toJson());
    pref.setString('currentSong', userJson);
  }

  static bool get firstLogin => pref.getBool('firstLogin') ?? true;
  static set firstLogin(bool newValue) => pref.setBool('firstLogin', newValue);
}