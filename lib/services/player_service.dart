import 'package:just_audio/just_audio.dart';
import 'package:simple_mp3/services/alert_service.dart';

class PlayerService {
  static final  AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> playMusic(String path) async {
    try {
      await _audioPlayer.setFilePath(path);
      _audioPlayer.play();
    } catch (e) {
      AlertService.showBasicAlert("Error: ${e.toString()}");
    }
  }
}