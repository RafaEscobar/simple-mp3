import 'package:permission_handler/permission_handler.dart';
import 'package:simple_mp3/services/preferences_service.dart';

class PermissionService {
  static Future<void> storageAccessRequest() async {
    //* Solicitamos permiso al usuario para ingresar al almacenamiento interno
    PreferencesService.storagePermissionResponse = await Permission.storage.request();
  }
}