import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:simple_mp3/models/song.dart';

class AppProvider extends ChangeNotifier{
  bool _hasShownSplash = false;
  bool _isReproducing = false;
  List<Song> _songList = [];
  ConcatenatingAudioSource _playList = ConcatenatingAudioSource(
    children: []
  );
  final  AudioPlayer _audioPlayer = AudioPlayer();

  AudioPlayer get audioPlayer => _audioPlayer;

  ConcatenatingAudioSource get playList => _playList;
  set playList(ConcatenatingAudioSource newValue){
    _playList = newValue;
    notifyListeners();
  }

  bool get isReproducing => _isReproducing;
  set isReproducing(bool newValue){
    _isReproducing = newValue;
    notifyListeners();
  }

  bool get hasShownSplash => _hasShownSplash;
  set hasShownSplash(bool newValue){
    _hasShownSplash = newValue;
    notifyListeners();
  }

  List<Song> get songList => _songList;
  set songList(List<Song> newList){
    _songList = newList;
    notifyListeners();
  }

  void clean(){
    _hasShownSplash = false;
    _songList = [];
    notifyListeners();
  }
}