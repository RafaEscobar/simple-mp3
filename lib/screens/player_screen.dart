import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_mp3/services/preferences.dart';
import 'package:simple_mp3/utils/alert.dart';
import 'package:simple_mp3/utils/local_permission.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});
  static const String routeName = 'playerSPlayerScreen-screen';

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late PermissionStatus showNoPermission;

  @override
  void initState() {
    super.initState();
    showNoPermission = Preferences.storagePermissionResponse;
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
                const Text(
                  'Necesitamos permiso para buscar tu música',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10,),
                Lottie.asset('assets/animations/empty_state.json'),
                const SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () async {
                    if (Preferences.storagePermissionResponse.isPermanentlyDenied) {
                      Alert.showBasicAlert('A continuación seras redirigido a la configuración de la aplicación, ahi podras conceder el permiso para acceder al almacenamiento interno');
                      await Future.delayed(const Duration(seconds: 5));
                      openAppSettings();
                    } else {
                      PermissionStatus statusRequest = await LocalPermission.requestPermission();
                      Preferences.storagePermissionResponse = statusRequest;
                    }
                  },
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