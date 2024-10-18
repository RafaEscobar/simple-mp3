
import 'package:flutter/services.dart';

class Song {
  final String title;
  final String artist;
  final String duration;
  final Uint8List? coverPage;

  Song({
    this.title = '',
    this.artist = '',
    this.duration = '',
    this.coverPage,
  });
}