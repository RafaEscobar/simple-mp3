import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:simple_mp3/screens/player_screen.dart';
import 'package:simple_mp3/services/permission_service.dart';
import 'package:simple_mp3/services/preferences_service.dart';
import 'package:simple_mp3/services/providers/app_provider.dart';
import 'package:simple_mp3/use_cases/music_use_case.dart';

class LoadScreen extends StatefulWidget{
  static const String routeName = 'load-screen';
  const LoadScreen({super.key});

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  Future<void> _initLoad() async {
    /*
      * Validamos:
        * - SI el usuario acepto que la aplicación pueda acceder al almacenamiento del dispositivo procedera con la busqueda de las canciones
        * - SI NO acepta se le redireccionara a otra screen en donde se le muestre un mensaje indicando que si no acepta no podra escuhar sus canciones
    */
      //* Función que lanza la solicitud de permiso
    if (!PreferencesService.storagePermissionResponse.isGranted){
      await PermissionService.requestAccessToStorage();
      PreferencesService.firstLogin = false;
    }
    await Future.delayed(const Duration(seconds: 2));
    if (PreferencesService.storagePermissionResponse.isGranted) await MusicUseCase.search();
    if (mounted) context.pushNamed(PlayerScreen.routeName);
  }

  void _hideSplash(){
    AppProvider providerReader = context.read<AppProvider>();
    if (!providerReader.hasShownSplash) providerReader.hasShownSplash = true;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), _initLoad);
    WidgetsBinding.instance.addPostFrameCallback((_){
      _hideSplash();
    });
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
              SizedBox(
                width: size.width * .4,
                child: Image.asset('assets/images/logo.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}