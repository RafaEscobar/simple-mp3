import 'package:flutter/services.dart';

class Song {
  final String title;
  final String artist;
  final String duration;
  final Uint8List? coverPage;
  final String path;

  Song({
    this.title = '',
    this.artist = '',
    this.duration = '',
    this.path = '',
    this.coverPage,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'artist': artist,
    'duration': duration,
    'coverPage': coverPage,
    'path': path
  };

  factory Song.fromJson(Map<String, dynamic> json) => Song(
    title: json['title'] ?? '',
    artist: json['artist'] ?? '',
    path: json['path'] ?? '',
    duration: json['duration'] ?? '',
    coverPage: Uint8List.fromList(json['coverPage'].cast<int>()),
  );
}