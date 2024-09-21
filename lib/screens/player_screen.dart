import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_mp3/services/preferences.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});
  static const String routeName = 'playerSPlayerScreen-screen';

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late bool showNoPermission;

  @override
  void initState() {
    super.initState();
    showNoPermission = Preferences.storagePermission;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: (showNoPermission) ?
        Container(
          color: Colors.white,
          child: const Text('AQUI IRA EL REPRODUCTOR DE MUSICA')
        ) :
        SizedBox(
          child: Column(
            children: [
              const Text(
                'No tenemos tu permiso para buscar tu música'
              ),
              Lottie.asset('assets/animations/empty_state.json')
            ],
          ),
        )
      ),
    );
  }
}