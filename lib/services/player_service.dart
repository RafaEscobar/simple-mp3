import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_mp3/main.dart';
import 'package:simple_mp3/services/providers/app_provider.dart';

class PlayerService {
  static final AppProvider _readProvider = navigatorKey.currentContext!.read<AppProvider>();

  static Future<void> toogleMusic({bool? isStopping = false}) async {
    try {
      if (!_readProvider.isReproducing) {
        _readProvider.audioPlayer.play();
        _readProvider.isReproducing = true;
      } else {
        if (isStopping!) {
          _readProvider.audioPlayer.pause();
          _readProvider.isReproducing = false;
        } else {
          _readProvider.audioPlayer.play();
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}