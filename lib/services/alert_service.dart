
import 'package:flutter/material.dart';
import 'package:simple_mp3/main.dart';

class AlertService {
  static void showBasicAlert(String message){
    showModalBottomSheet(
      context: navigatorKey.currentContext!,
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