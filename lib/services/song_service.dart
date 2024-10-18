import 'package:flutter/services.dart';

class SongService {
   static Future<Uint8List> buildCoverPage() async {
    ByteData bytes = await rootBundle.load('assets/images/album_default.jpg');
    return bytes.buffer.asUint8List();
  }

  static String buildTrakName(String path){
    List<String> words = path.split('/');
    int limit = (words[words.length-1].length-4);
    return words[words.length-1].substring(0, limit);
  }
}