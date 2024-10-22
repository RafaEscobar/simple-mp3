import 'package:flutter/material.dart';
import 'package:simple_mp3/models/song.dart';

class AppProvider extends ChangeNotifier{
  bool _hasShownSplash = false;
  List<Song> _songList = [];
  Song _currentSong = Song(
    artist: '',
    duration: '',
    title: '',
    path: '',
  );

  bool get hasShownSplash => _hasShownSplash;
  List<Song> get songList => _songList;
  Song get currentSong => _currentSong;

  set hasShownSplash(bool newValue){
    _hasShownSplash = newValue;
    notifyListeners();
  }

  set songList(List<Song> newList){
    _songList = newList;
    notifyListeners();
  }

  set currentSong(Song newSong){
    _currentSong = newSong;
    notifyListeners();
  }

  void clean(){
    _hasShownSplash = false;
    notifyListeners();
  }
}