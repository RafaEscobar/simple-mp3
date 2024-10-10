import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_mp3/screens/player_screen.dart';
import 'package:simple_mp3/services/preferences.dart';
import 'package:simple_mp3/utils/local_permission.dart';
import 'package:simple_mp3/utils/music.dart';

class LoadScreen extends StatefulWidget{
  static const String routeName = 'load-screen';
  const LoadScreen({super.key});

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  void initLoad() async {
    //* Función que lanza la solicitud de permiso
    Preferences.storagePermissionResponse = await LocalPermission.requestPermission();
    /*
      * Validamos:
        * - SI el usuario acepto que la aplicación pueda acceder al almacenamiento del dispositivo procedera con la busqueda de las canciones
        * - SI NO acepta se le redireccionara a otra screen en donde se le muestre un mensaje indicando que si no acepta no podra escuhar sus canciones
    */
    if (Preferences.storagePermissionResponse.isGranted) {
      //* Buscamos la musica en el dispositivo
      await Music.search();
      await Future.delayed(const Duration(seconds: 1));
    }
    if (mounted) context.goNamed(PlayerScreen.routeName);
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