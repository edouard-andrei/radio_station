import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_romania/constants/stations.dart';

class AudioPlayerTask extends BackgroundAudioTask {
  final AudioPlayer _player = AudioPlayer();
  final MediaLibrary _mediaLibrary = MediaLibrary();

  bool _playing = false;

  List<MediaItem> get queue => _mediaLibrary.stations;

  int get index => _player.currentIndex;

  @override
  Future<void> onSkipToPrevious() async {
    await _player.seekToPrevious();
  }

  @override
  Future<void> onPlay() async {
    _player.play();
    await AudioServiceBackground.setState(
      controls: <MediaControl>[
        MediaControl.skipToPrevious,
        MediaControl.pause,
        MediaControl.skipToNext
      ],
      processingState: _playerState2APS(_player.playerState.processingState),
      playing: true,
    );
  }

  @override
  Future<void> onPause() async {
    await _player.pause();
    await AudioServiceBackground.setState(
      controls: <MediaControl>[
        MediaControl.skipToPrevious,
        MediaControl.play,
        MediaControl.skipToNext
      ],
      processingState: _playerState2APS(_player.playerState.processingState),
      playing: false,
    );
  }

  @override
  Future<void> onSkipToNext() async {
    await _player.seekToNext();
  }

  @override
  Future<void> onSkipToQueueItem(String mediaId) async {
    int _index = queue.indexWhere((station) => station.id == mediaId);
    _player.seek(Duration.zero, index: _index);
    AudioServiceBackground.setMediaItem(queue.elementAt(_index));
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
  Future<void> onStart(Map<String, dynamic> params) async {
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

    await _player.setLoopMode(LoopMode.all);

    _player.currentIndexStream.listen((index) async {
      if (index != null) {
        MediaItem mediaItem = queue[index];
        AudioServiceBackground.setMediaItem(mediaItem);
      }
    });

    // Listen for play/pause changes
    _player.playerStateStream.listen((playerState) {
      _playing = playerState.playing;
    });

    // Need to set queue so background clients know the queue
    await AudioServiceBackground.setQueue(queue);

    // Update notification UI
    await AudioServiceBackground.setState(
      controls: <MediaControl>[
        MediaControl.skipToPrevious,
        _playing ? MediaControl.pause : MediaControl.play,
        MediaControl.skipToNext
      ],
      processingState: _playerState2APS(_player.playerState.processingState),
      playing: _playing,
    );
  }

  @override
  Future<void> onStop() async {
    await _player.pause();
    await _player.dispose();
    super.onStop();
  }

  AudioProcessingState _playerState2APS(ProcessingState playerState) {
    if (playerState == ProcessingState.loading)
      return AudioProcessingState.connecting;
    if (playerState == ProcessingState.buffering)
      return AudioProcessingState.buffering;
    if (playerState == ProcessingState.ready) return AudioProcessingState.ready;
    if (playerState == ProcessingState.completed)
      return AudioProcessingState.completed;
    return AudioProcessingState.none;
  }
}
