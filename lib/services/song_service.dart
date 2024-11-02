import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_mp3/main.dart';

class SongService {
   static Future<Uint8List> buildCoverPage() async {
    try {
      ByteData bytes = await rootBundle.load('assets/images/album_default.jpg');
      return bytes.buffer.asUint8List();
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(content: Text(e.toString())));
      throw Exception(e.toString());
    }
  }

  static String buildTrakName(String path){
    try {
      List<String> words = path.split('/');
      int limit = (words[words.length-1].length-4);
      return words[words.length-1].substring(0, limit);
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(content: Text(e.toString())));
      throw Exception(e.toString());
    }
  }
}