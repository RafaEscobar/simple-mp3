import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_mp3/services/alert_service.dart';
import 'package:simple_mp3/services/permission_service.dart';
import 'package:simple_mp3/services/preferences_service.dart';
import 'package:simple_mp3/use_cases/player/player_header.dart';
import 'package:simple_mp3/widgets/controls_player.dart';
import 'package:simple_mp3/widgets/empty_state.dart';

class PlayerScreen extends StatefulWidget {
  static const String routeName = 'playerSPlayerScreen-screen';
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late PermissionStatus showNoPermission;

  Future<void> requestPermissionAgain() async {
    if (PreferencesService.storagePermissionResponse.isPermanentlyDenied) {
      AlertService.showBasicAlert('A continuación seras redirigido a la configuración de la aplicación, ahi podras conceder el permiso para acceder al almacenamiento interno');
      await Future.delayed(const Duration(seconds: 5));
      openAppSettings();
    } else {
      await PermissionService.requestAccessToStorage();
    }
  }

  @override
  void initState() {
    super.initState();
    showNoPermission = PreferencesService.storagePermissionResponse;
  }

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: (showNoPermission.isGranted) ?
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          color: Colors.white,
          child: const Column(
            children: [
              PlayerHeader(),
              SizedBox(height: 20,),
            ],
          )
        ) :
        EmptyState(
          lottiePath: 'assets/animations/empty_state.json',
          title: 'Necesitamos permiso para buscar música en tu dispositivo',
          body: ElevatedButton(
            onPressed: requestPermissionAgain,
            child: const Text('Conceder permiso')
          )
        )
      ),
      bottomNavigationBar: ControlsPlayer(height: size.height, musicName: 'Nombre de la...')
    );
  }
}