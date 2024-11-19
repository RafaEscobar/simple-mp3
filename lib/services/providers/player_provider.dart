import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:simple_mp3/models/song.dart';

class PlayerProvider extends ChangeNotifier{
  final  AudioPlayer _audioPlayer = AudioPlayer();
  List<Song> _songList = [];
  ConcatenatingAudioSource _playList = ConcatenatingAudioSource(children: []);

  AudioPlayer get audioPlayer => _audioPlayer;

  ConcatenatingAudioSource get playList => _playList;
  set playList(ConcatenatingAudioSource newValue){
    _playList = newValue;
    notifyListeners();
  }

  List<Song> get songList => _songList;
  set songList(List<Song> newList){
    _songList = newList;
    notifyListeners();
  }
}