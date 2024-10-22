import 'package:flutter/material.dart';
import 'package:simple_mp3/screens/player_screen.dart';

class AppRoute {
  static Map<String, WidgetBuilder> routes = {
    '/player': (context) => const PlayerScreen()
  };
}