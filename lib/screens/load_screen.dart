import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_mp3/screens/player_screen.dart';
import 'package:simple_mp3/services/preferences.dart';
import 'package:simple_mp3/utils/alert.dart';

class LoadScreen extends StatefulWidget{
  const LoadScreen({super.key});
  static const String routeName = 'load-screen';

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {

  Future<PermissionStatus> requestPermission() async {
    //* Solicitamos permiso al usuario para ingresar al almacenamiento interno
    PermissionStatus status = await Permission.storage.request();
    return status;
  }

  Future<void> searchMusic() async {
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
        Alert.showBasicAlert(e.toString());
      }
    }

    //* Establecemos el directorio raiz del telefono como directorio inicial para la busqueda
    Directory rootDir = Directory('/storage/emulated/0');
    //* Llamamos por primera vez a la función recursiva
    await listFiles(rootDir);
  }

  void initLoad() async {
    PermissionStatus statusRequest = await requestPermission();
    /*
      * Validamos:
        * - SI el usuario acepto que la aplicación pueda acceder al almacenamiento del dispositivo procedera con la busqueda de las canciones
        * - SI NO acepta se le redireccionara a otra screen en donde se le muestre un mensaje indicando que si no acepta no podra escuhar sus canciones
    */
    print(statusRequest);
    if (statusRequest.isGranted) {
      //* Si paths contiene algo eso indica que hay musica en el dispositivo, de no haber se le indica al usuario.
      await searchMusic();
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) context.goNamed(PlayerScreen.routeName);
      //! REDIRECCIÓN AL HOME
    } else if(statusRequest.isDenied || statusRequest.isPermanentlyDenied){
      Preferences.storagePermission = false;
      if (mounted) context.goNamed(PlayerScreen.routeName);
    }
  }

  @override
  void initState() {
    initLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Estamos buscando tu música...',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22
                ),
              ),
              const SizedBox(height: 38,),
              SizedBox(
                width: size.width * .3,
                child: Lottie.asset('assets/animations/load.json'),
              ),
              const SizedBox(height: 30,),
              const Text(
                'Esto solo sucedera una vez.',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}