

import 'package:flutter/services.dart';

class CoverPageService {
   static Future<Uint8List> getDefaultCoverPage() async {
    ByteData bytes = await rootBundle.load('assets/images/album_default.jpg');
    return bytes.buffer.asUint8List();
  }
}