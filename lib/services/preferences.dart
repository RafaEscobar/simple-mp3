import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences pref;

  static Future<void> init() async => pref = await SharedPreferences.getInstance();

  static bool get storagePermission => pref.getBool('hasStoragePermission') ?? false;
  static set storagePermission(bool newValue) => pref.setBool('hasStoragePermission', newValue);
}