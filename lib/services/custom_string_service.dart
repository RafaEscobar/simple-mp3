import 'package:flutter/material.dart';
import 'package:simple_mp3/main.dart';

class CustomStringService {
  static String cropTitle({required String data, required int length}){
    try {
      if (data.length<length) return data;
      return "${data.substring(0, length)}...";
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(content: Text(e.toString())));
      throw Exception(e.toString());
    }
  }
}