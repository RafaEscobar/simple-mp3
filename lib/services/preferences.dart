import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences pref;

  static bool get storagePermission => pref.getBool('p_storagePermission') ?? false;
  static set storagePermission(bool newValue) => pref.setBool('p_storagePermission', newValue);
}