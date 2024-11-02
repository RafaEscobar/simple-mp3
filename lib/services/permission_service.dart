import 'package:permission_handler/permission_handler.dart';
import 'package:simple_mp3/services/alert_service.dart';
import 'package:simple_mp3/services/preferences_service.dart';

class PermissionService {
  //* Solicitamos permiso al usuario para ingresar al almacenamiento interno
  static Future<void> requestAccessToStorage() async => PreferencesService.storagePermissionResponse = await Permission.storage.request();

  static Future<void> requestPermissionAgain() async {
    if (PreferencesService.storagePermissionResponse.isPermanentlyDenied) {
      AlertService.showBasicAlert('A continuación seras redirigido a la configuración de la aplicación, ahi podras conceder el permiso para acceder al almacenamiento interno');
      await Future.delayed(const Duration(seconds: 5));
      openAppSettings();
    } else {
      await PermissionService.requestAccessToStorage();
    }
  }
}