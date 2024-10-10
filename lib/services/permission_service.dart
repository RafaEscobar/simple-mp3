import 'package:permission_handler/permission_handler.dart';
import 'package:simple_mp3/services/preferences_service.dart';

class PermissionService {
  //* Solicitamos permiso al usuario para ingresar al almacenamiento interno
  static Future<void> requestAccessToStorage() async => PreferencesService.storagePermissionResponse = await Permission.storage.request();
}