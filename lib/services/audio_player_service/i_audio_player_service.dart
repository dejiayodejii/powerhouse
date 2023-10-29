import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'audio_player_service.dart';

abstract class IAudioPlayerService {
  Stream<Duration> get currentPosition;
  Duration? get duration;
  bool get isPlaying;

  Future<void> init(String url);
  Future<void> play();
  Future<void> pause();
  Future<void> stop();
  Future<void> seek(Duration position);
  Future<void> dispose();
}

final audioPlayerService = Provider<IAudioPlayerService>(
  (_) => AudioPlayerService(),
);
