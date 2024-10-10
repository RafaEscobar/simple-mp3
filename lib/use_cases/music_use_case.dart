import 'dart:io';

import 'package:simple_mp3/services/alert_service.dart';

class MusicUseCase {
    static Future<void> search() async {
    //* Listado en donde se guardaran las rutas de las canciones
    List<String> paths = [];
    //* Listado de carpetas cuyo acceso es restringido por android (NO HAREMOS BUSQUEDA EN ESTAS CARPETAS)
    List<String> restrictedDirectories = [
      '/storage/emulated/0/Android',
      '/storage/emulated/0/Android/data',
      '/storage/emulated/0/Android/obb',
    ];

    //* Función para listar los archivos encontrados.
    Future<void> listFiles(Directory dir) async {
      //* Bandera para determinar si la ruta actual es accesible o no (true: no accesible, false: es accesible)
      bool isRestricted = true;
      try {
        //* Aqui obtenemos: el listado de directorios en la raiz
        List<FileSystemEntity> entities = dir.listSync();
        //* Con este for recorremos todos esos directorios uno a uno (incluyendo sus sub-rutas)
        for (FileSystemEntity entity in entities) {
          /*
            * -una entidad puede ser un directorio o un archivo-
            * Si la entidad encontrada es un directorio entrara al if
            * Si es un archivo y ademas tiene extensión .mp3 entrara en el else if
          */
          if (entity is Directory) {
            //* Verifica si el directorio es accesible o no
            /*
              * - "La entidad directorio de esta vuela empieza (es igual) a algun directorio restringido de los guardaddos en -restrictedDirectories-"
            */
            isRestricted = restrictedDirectories.any((restrictedDir) => entity.path.startsWith(restrictedDir));
            /*
              * SI NO esta restringido llama de nuevo a la FUNCIÓN RECURSIVA -listFiles- enviando como argumento la entidad directorio actual
              * SI ESTA RESTRINGIDA no hagas nada y continua con la siguiente vuelta
            */
            if (!isRestricted) await listFiles(Directory(entity.path));
          } else if (entity is File && entity.path.endsWith('.mp3')) {
            //* Agregamos el path de la canción a nuestro listado final de paths
            paths.add(entity.path);
          }
        }
      } catch (e) {
        //* Catch de errores no controlados
        AlertService.showBasicAlert(e.toString());
      }
    }

    //* Establecemos el directorio raiz del telefono como directorio inicial para la busqueda
    Directory rootDir = Directory('/storage/emulated/0');
    //* Llamamos por primera vez a la función recursiva
    await listFiles(rootDir);
  }
}