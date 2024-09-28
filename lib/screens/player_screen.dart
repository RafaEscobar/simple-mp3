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
                Lottie.asset('assets/animations/empty_state.json')
              ],
            ),
          ),
        )
      ),
    );
  }
}