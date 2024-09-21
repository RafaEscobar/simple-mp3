
import 'package:flutter/material.dart';
import 'package:simple_mp3/main.dart';

class Alert {
  static void showBasicAlert(String message){
    showModalBottomSheet(
      context: MyApp.navigatorKey.currentContext!,
      builder: (context) {
        return Container(
          color: Colors.greenAccent,
          child: Center(
            child: Text(message),
          ),
        );
      },
    );
  }
}