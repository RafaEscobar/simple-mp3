import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_mp3/services/alert_service.dart';
import 'package:simple_mp3/services/permission_service.dart';
import 'package:simple_mp3/services/preferences_service.dart';
import 'package:simple_mp3/use_cases/player/player_header.dart';
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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: size.height * .12,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              color: Colors.blue
            )
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Row(
                children: [
                  Container(
                    width: size.height * .06,
                    height: size.height * .06,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        width: 0.8
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  const Text(
                    'Titulo de la can...',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              child: Row(
                children: [
                  Icon(
                    Ionicons.play_back_circle_outline,
                    size: 40,
                  ),
                  SizedBox(width: 12,),
                  Icon(
                    Ionicons.play_circle_outline,
                    size: 40,
                  ),
                  SizedBox(width: 12,),
                  Icon(
                    Ionicons.play_forward_circle_outline,
                    size: 40,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}