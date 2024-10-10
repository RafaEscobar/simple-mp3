import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_mp3/services/alert_service.dart';
import 'package:simple_mp3/services/permission_service.dart';
import 'package:simple_mp3/services/preferences_service.dart';
import 'package:simple_mp3/widgets/empty_state.dart';

class PlayerScreen extends StatefulWidget {
  static const String routeName = 'playerSPlayerScreen-screen';
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late PermissionStatus showNoPermission;

  Future<void> requestPermission() async {
    if (PreferencesService.storagePermissionResponse.isPermanentlyDenied) {
      AlertService.showBasicAlert('A continuación seras redirigido a la configuración de la aplicación, ahi podras conceder el permiso para acceder al almacenamiento interno');
      await Future.delayed(const Duration(seconds: 5));
      openAppSettings();
    } else {
      await PermissionService.storageAccessRequest();
    }
  }

  @override
  void initState() {
    super.initState();
    showNoPermission = PreferencesService.storagePermissionResponse;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: (showNoPermission.isGranted) ?
        Container(
          color: Colors.white,
          child: const Text('AQUI IRA EL REPRODUCTOR DE MUSICA')
        ) :
        Center(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const EmptyState(
                  lottiePath: 'assets/animations/empty_state.json',
                  title: 'Necesitamos permiso para buscar tu música'
                ),
                ElevatedButton(
                  onPressed: requestPermission,
                  child: const Text('Conceder permiso')
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}