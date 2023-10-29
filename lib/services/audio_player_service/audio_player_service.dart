import 'package:just_audio/just_audio.dart';

import 'i_audio_player_service.dart';

class AudioPlayerService extends IAudioPlayerService {
  final player = AudioPlayer();
  Duration? _duration;
  bool _isPlaying = false;

  @override
  Future<void> init(String url) async {
    _duration = await player.setUrl(url);
  }

  @override
  Future<void> pause() async {
    await player.pause();
    _isPlaying = false;
    return;
  }

  @override
  Future<void> play() async {
    await player.play();
    _isPlaying = true;
  }

  @override
  Future<void> seek(Duration position) async {
    await player.seek(position);
  }

  @override
  Future<void> stop() async {
    await player.stop();
    _isPlaying = false;
  }

  @override
  Future<void> dispose() async {
    await player.stop();
    _isPlaying = false;
    _duration = null;
  }

  @override
  Stream<Duration> get currentPosition => player.positionStream;

  @override
  Duration? get duration => _duration;

  @override
  bool get isPlaying => _isPlaying;
}
