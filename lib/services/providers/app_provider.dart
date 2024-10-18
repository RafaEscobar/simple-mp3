import 'package:flutter/material.dart';
import 'package:simple_mp3/models/song.dart';

class AppProvider extends ChangeNotifier{
  bool _hasShownSplash = false;
  List<Song> _songList = [];

  bool get hasShownSplash => _hasShownSplash;
  List<Song> get songList => _songList;

  set hasShownSplash(bool newValue){
    _hasShownSplash = newValue;
    notifyListeners();
  }

  set songList(List<Song> newList){
    _songList = newList;
    notifyListeners();
  }

  void clean(){
    _hasShownSplash = false;
    notifyListeners();
  }
}