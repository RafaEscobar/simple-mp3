import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:simple_mp3/main.dart';

class PlayerService {
  static final  AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> playMusic(String path) async {
    try {
      await _audioPlayer.setFilePath(path);
      _audioPlayer.play();
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}