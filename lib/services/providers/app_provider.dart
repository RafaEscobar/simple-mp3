import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier{
  bool _hasShownSplash = false;

  bool get hasShownSplash => _hasShownSplash;

  set hasShownSplash(bool newValue){
    _hasShownSplash = newValue;
    notifyListeners();
  }

  void clean(){
    _hasShownSplash = false;
    notifyListeners();
  }
}