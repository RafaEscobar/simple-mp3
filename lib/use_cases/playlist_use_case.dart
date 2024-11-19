import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:simple_mp3/main.dart';
import 'package:simple_mp3/models/song.dart';
import 'package:simple_mp3/services/providers/app_provider.dart';

class PlaylistUseCase {
  static final AppProvider _appProvider = navigatorKey.currentContext!.read<AppProvider>();
  static void buildPlayList() async {
    _appProvider.playList = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: getSources(),
    );
    _appProvider.audioPlayer.setAudioSource(_appProvider.playList);
  }

  static List<AudioSource> getSources() {
  List<Song> songs = _appProvider.songList;
  return songs.map((song) {
    return AudioSource.uri(Uri.file(song.path));
  }).toList();
 }
}