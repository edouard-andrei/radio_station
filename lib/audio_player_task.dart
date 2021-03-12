import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_romania/constants/stations.dart';

class AudioPlayerTask extends BackgroundAudioTask {
  final AudioPlayer _player = AudioPlayer();
  final MediaLibrary _mediaLibrary = MediaLibrary();

  AudioProcessingState? _skipState;
  StreamSubscription<PlaybackEvent>? _eventSubscription;

  bool _playing = false;

  List<MediaItem> get queue => _mediaLibrary.stations;

  int? get index => _player.currentIndex;

  @override
  Future<void> onSkipToPrevious() => _player.seekToPrevious();

  @override
  Future<void> onPlay() => _player.play();

  @override
  Future<void> onPause() => _player.pause();

  @override
  Future<void> onSkipToNext() => _player.seekToNext();

  @override
  Future<void> onSkipToQueueItem(String mediaId) async {
    int _index = queue.indexWhere((station) => station.id == mediaId);
    if (_index == -1) return;
    _player.seek(Duration.zero, index: _index);
  }

  @override
  Future<void> onClick(MediaButton button) async {
    switch (button) {
      case MediaButton.next:
        onSkipToNext();
        break;
      case MediaButton.previous:
        onSkipToPrevious();
        break;
      default:
        _playing ? onPause() : onPlay();
        break;
    }
  }

  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());

    _eventSubscription = _player.playbackEventStream.listen((event) {
      _broadcastState();
    });

    await _player.setLoopMode(LoopMode.all);

    // Listen for current media item index
    _player.currentIndexStream.listen((index) async {
      if (index != null) {
        AudioServiceBackground.setMediaItem(queue[index]);
      }
    });

    // Listen for play/pause changes
    _player.playerStateStream.listen((playerState) {
      _playing = playerState.playing;
    });

    _player.icyMetadataStream.listen((icyMetadata) {
      AudioServiceBackground.sendCustomEvent(icyMetadata);
    });

    // Need to set queue so background clients know the queue
    await AudioServiceBackground.setQueue(queue);

    // Setup player radio queue
    await _player.setAudioSource(
      ConcatenatingAudioSource(
        children: queue
            .map((station) => AudioSource.uri(Uri.parse(station.id)))
            .toList(),
      ),
      initialIndex: 0,
      preload: false,
    );
  }

  @override
  Future<void> onStop() async {
    await _player.dispose();
    _eventSubscription?.cancel();
    // It is important to wait for this state to be broadcast before we shut
    // down the task. If we don't, the background task will be destroyed before
    // the message gets sent to the UI.
    await _broadcastState();
    // Shut down this task
    await super.onStop();
  }

  Future<void> _broadcastState() async {
    await AudioServiceBackground.setState(
      controls: [
        MediaControl.skipToPrevious,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      androidCompactActions: [0, 1, 2],
      processingState: _getProcessingState(),
      playing: _player.playing,
    );
  }

  /// Maps just_audio's processing state into into audio_service's playing
  /// state. If we are in the middle of a skip, we use [_skipState] instead.
  AudioProcessingState _getProcessingState() {
    if (_skipState != null) return _skipState!;
    switch (_player.processingState) {
      case ProcessingState.idle:
        return AudioProcessingState.stopped;
      case ProcessingState.loading:
        return AudioProcessingState.connecting;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
      default:
        throw Exception("Invalid state: ${_player.processingState}");
    }
  }
}
