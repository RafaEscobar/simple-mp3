import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_mp3/main.dart';
import 'package:simple_mp3/services/providers/player_provider.dart';

class PlayerService {
  static final PlayerProvider _readProvider = navigatorKey.currentContext!.read<PlayerProvider>();

  static Future<void> toogleMusic({bool isStopping = false, required int index}) async {
    try {

      /*
      print(_readProvider.audioPlayer);
      if (!isStopping) {
          _readProvider.audioPlayer.seek(
            Duration.zero,
            index: index
          );
          _readProvider.audioPlayer.play();
          _readProvider.isReproducing = true;
      } else {
        if (_readProvider.isReproducing) {
           _readProvider.isReproducing = false;
          _readProvider.audioPlayer.pause();
        } else {
          _readProvider.audioPlayer.play();
          _readProvider.isReproducing = true;
        }
      }
      */
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  static Future<void> nextSong() async => _readProvider.audioPlayer.seekToNext();
  static Future<void> previoudSong() async => _readProvider.audioPlayer.seekToPrevious();
}