import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static late SharedPreferences pref;

  static Future<void> init() async => pref = await SharedPreferences.getInstance();

  static PermissionStatus get storagePermissionResponse{
    int indexValue = pref.getInt('storagePermissionResponse')!;
    return PermissionStatus.values[indexValue];
  }
  static set storagePermissionResponse(PermissionStatus newValue) => pref.setInt('storagePermissionResponse', newValue.index);
}