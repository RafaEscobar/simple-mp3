import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
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
    if (!PreferencesService.storagePermissionResponse.isGranted){
      await PermissionService.requestAccessToStorage();
      PreferencesService.firstLogin = false;
    }
    if (PreferencesService.storagePermissionResponse.isGranted) await MusicUseCase.search();
  }

  void _hideSplash(){
    AppProvider providerReader = context.read<AppProvider>();
    if (!providerReader.hasShownSplash) providerReader.hasShownSplash = true;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _hideSplash();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      curve: Curves.easeInOut,
      duration: 3000,
      pageTransitionType: PageTransitionType.topToBottom,
      splashTransition: SplashTransition.slideTransition,
      splash: 'assets/images/logo.png',
      screenFunction: () async {
        await _initLoad();
        return const PlayerScreen();
      },
    );
  }
}