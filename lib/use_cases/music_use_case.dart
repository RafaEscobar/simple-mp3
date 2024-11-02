import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:provider/provider.dart';
import 'package:simple_mp3/main.dart';
import 'package:simple_mp3/models/song.dart';
import 'package:simple_mp3/services/song_service.dart';
import 'package:simple_mp3/services/providers/app_provider.dart';

class MusicUseCase {
  //* Listado en donde se guardaran las rutas de las canciones
  static List<Song> paths = [];
  //* Listado de carpetas cuyo acceso es restringido por android (NO HAREMOS BUSQUEDA EN ESTAS CARPETAS)
  static List<String> restrictedDirectories = [
    '/storage/emulated/0/Android',
    '/storage/emulated/0/Android/data',
    '/storage/emulated/0/Android/obb',
  ];
  static Future<void> search() async {
    try {
      Uint8List defaultImage = await SongService.buildCoverPage();
      //* Establecemos el directorio raiz del telefono como directorio inicial para la busqueda
      Directory rootDir = Directory('/storage/emulated/0');
      //* Llamamos por primera vez a la función recursiva
      await listFiles(rootDir, defaultImage);
      navigatorKey.currentContext!.read<AppProvider>().songList = paths;
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //! Función iterable para listar los archivos encontrados.
  static Future<void> listFiles(Directory dir, Uint8List defaultImage) async {
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
          if (!isRestricted) await listFiles(Directory(entity.path), defaultImage);
        } else if (entity is File && entity.path.endsWith('.mp3')) {
          final metadata = await MetadataRetriever.fromFile(File(entity.path));
          //* Agregamos el path de la canción a nuestro listado final de paths
          paths.add(buildSong(metadata, defaultImage));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //! Función para generar la entidad de la canción
  static Song buildSong(Metadata metadata, Uint8List defaultImage) {
    try {
      return Song(
        title: metadata.trackName ?? SongService.buildTrakName(metadata.filePath!),
        artist: metadata.trackArtistNames?.join(', ') ?? 'Desconocido',
        duration: metadata.trackDuration.toString(),
        coverPage: metadata.albumArt ?? defaultImage,
        path: metadata.filePath ?? '',
      );
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(content: Text(e.toString())));
      throw Exception(e.toString());
    }
  }
}