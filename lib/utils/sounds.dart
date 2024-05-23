import 'package:flame_audio/flame_audio.dart';

class Sounds {
  static Future initialize() async {
    FlameAudio.bgm.initialize();
  }

  static stopBackgroundSound() {
    return FlameAudio.bgm.stop();
  }

  static void playBackgroundSound() async {
    await FlameAudio.bgm.stop();
    FlameAudio.bgm.play('sound_bg.mp3', volume: .1);
  }

  static void pauseBackgroundSound() {
    FlameAudio.bgm.pause();
  }

  static void resumeBackgroundSound() {
    FlameAudio.bgm.resume();
  }

  static void dispose() {
    FlameAudio.bgm.dispose();
  }
}
