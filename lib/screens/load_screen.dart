import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

class _LoadScreenState extends State<LoadScreen> with TickerProviderStateMixin {
  //* Controladores para animaciones de entrada y salida
  late AnimationController _entryController;
  late AnimationController _exitController;
  late Animation<double> _entryAnimation;
  late Animation<double> _exitAnimation;

  Future<void> _initLoad() async {
    if (!PreferencesService.storagePermissionResponse.isGranted){
      await PermissionService.requestAccessToStorage();
      PreferencesService.firstLogin = false;
    }
    await Future.delayed(const Duration(seconds: 1));
    if (PreferencesService.storagePermissionResponse.isGranted) await MusicUseCase.search();
    //* Inicia animación de salida
    _exitController.forward().then((value) => context.goNamed(PlayerScreen.routeName));
  }

  void _hideSplash(){
    AppProvider providerReader = context.read<AppProvider>();
    if (!providerReader.hasShownSplash) providerReader.hasShownSplash = true;
  }

  @override
  void initState() {
    super.initState();
    //* Inicializando controlador de animación de entrada
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    //* Inicializando controlador de animación de salida
    _exitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    //* Animación de entrada
    _entryAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeIn),
    );
    //* Animación de salida
    _exitAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeOut),
    );
    //* Iniciar animación de entrada
    _entryController.forward();

    //* Iniciar cargas
    _initLoad();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _hideSplash();
    });
  }

  @override
  void dispose() {
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