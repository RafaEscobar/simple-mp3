
import 'package:permission_handler/permission_handler.dart';

class LocalPermission {
  static Future<PermissionStatus> requestPermission() async {
    //* Solicitamos permiso al usuario para ingresar al almacenamiento interno
    PermissionStatus status = await Permission.storage.request();
    return status;
  }
}