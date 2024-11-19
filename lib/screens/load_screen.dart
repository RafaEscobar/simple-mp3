import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:simple_mp3/main.dart';
import 'package:simple_mp3/screens/player_screen.dart';
import 'package:simple_mp3/services/permission_service.dart';
import 'package:simple_mp3/services/preferences_service.dart';
import 'package:simple_mp3/services/providers/app_provider.dart';
import 'package:simple_mp3/services/providers/player_provider.dart';
import 'package:simple_mp3/use_cases/music_use_case.dart';
import 'package:simple_mp3/use_cases/playlist_use_case.dart';

class LoadScreen extends StatefulWidget{
  static const String routeName = 'load-screen';
  const LoadScreen({super.key});

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> with TickerProviderStateMixin {
  PlayerProvider providerRead = navigatorKey.currentContext!.read<PlayerProvider>();
  //* Controladores para animaciones de entrada y salida
  late AnimationController _entryController;
  late AnimationController _exitController;
  late Animation<double> _entryAnimation;
  late Animation<double> _exitAnimation;

  Future<void> _initLoad() async {
    //* Solicitar permiso
    await _requestAccessToStorage();
    //* Verificación de primer acceso a la app
    if (PreferencesService.firstLogin) PreferencesService.firstLogin = false;
    //* Retrazo inicial para splash
    await Future.delayed(const Duration(milliseconds: 600));
    if (PreferencesService.storagePermissionResponse.isGranted) await MusicUseCase.search();
    if (providerRead.songList.isNotEmpty) PlaylistUseCase.buildPlayList();
    //* Inicia animación de salida
    _exitController.forward().then((value) => context.goNamed(PlayerScreen.routeName));
  }

  Future<void> _requestAccessToStorage() async {
    //* Si ya se dio el permiso de acceso al almacenamiento ya no se vuelve a solicitar
    if (PreferencesService.storagePermissionResponse.isGranted) return;
    await PermissionService.requestAccessToStorage();
  }

  void _hideSplash(){
    AppProvider providerReader = context.read<AppProvider>();
    //* Si aun no se muestra la splash mostrarla (evita mostrar la splash cada que surge un cambio)
    if (!providerReader.hasShownSplash) context.read<AppProvider>().hasShownSplash = true;
  }

  @override
  void initState() {
    super.initState();
    //* Inicializando controladores de animación de entrada y salida
    _entryController = AnimationController(vsync: this,duration: const Duration(milliseconds: 500));
    _exitController = AnimationController(vsync: this,duration: const Duration(milliseconds: 600));
    //* Animación de entrada y salida
    _entryAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _entryController, curve: Curves.easeIn));
    _exitAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: _exitController, curve: Curves.easeOut),);
    //* Iniciar animación de entrada
    _entryController.forward();
    //* Iniciar cargas
    WidgetsBinding.instance.addPostFrameCallback((_){
      _initLoad();
      _hideSplash();
    });
  }

  @override
  void dispose() {
    //* Liberamos los controladores de las animaciones de entrada y salida
    _entryController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FadeTransition(
        opacity: _exitAnimation,
        child: FadeTransition(
          opacity: _entryAnimation,
          child: Container(
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
        ),
      ),
    );
  }
}