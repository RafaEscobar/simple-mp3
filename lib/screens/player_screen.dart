import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_mp3/screens/navigation/tabs_navigator.dart';
import 'package:simple_mp3/services/permission_service.dart';
import 'package:simple_mp3/services/preferences_service.dart';
import 'package:simple_mp3/widgets/player/player_header.dart';
import 'package:simple_mp3/widgets/player/controls_player.dart';
import 'package:simple_mp3/widgets/empty_state.dart';

class PlayerScreen extends StatefulWidget {
  static const String routeName = 'playerSPlayerScreen-screen';
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late PermissionStatus showNoPermission;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    super.initState();
    showNoPermission = PreferencesService.storagePermissionResponse;
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return (showNoPermission.isGranted) ?
      Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: const Column(
            children: [
              PlayerHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: TabsNavigator()
                )
              )
            ],
          )
        )
      ),
      bottomNavigationBar: const ControlsPlayer()
    ) : const Scaffold(
      body: EmptyState(
        lottiePath: 'assets/animations/empty_state.json',
        title: 'Necesitamos permiso para buscar música en tu dispositivo',
        body: ElevatedButton(
          onPressed: PermissionService.requestPermissionAgain,
          child: Text('Conceder permiso')
        )
      ),
    );
  }
}