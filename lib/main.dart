import 'package:flutter/material.dart';
import 'package:simple_mp3/screens/load_screen.dart';
import 'package:simple_mp3/screens/player.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const LoadScreen(),
    );
  }
}