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
    _player.seekToPrevious();
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
  Future<void> onPlay() async {
    _player.play();
    AudioServiceBackground.setState(
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
    _player.pause();
    AudioServiceBackground.setState(
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
    _player.seekToNext();
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
  Future<void> onSkipToQueueItem(String mediaId) async {
    _player.seek(Duration.zero,
        index: queue.indexWhere((station) => station.id == mediaId));
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
    await _player.load(
      LoopingAudioSource(
        count: queue.length,
        child: ConcatenatingAudioSource(
          children: queue
              .map((station) => AudioSource.uri(Uri.parse(station.id)))
              .toList(),
        ),
      ),
    );

    await AudioServiceBackground.setQueue(queue);

    _player.currentIndexStream.listen((index) async {
      if (index != null) {
        MediaItem mediaItem = await setMediaItem(index);
        AudioServiceBackground.setMediaItem(mediaItem);
      }
    });

    _player.playerStateStream.listen((playerState) {
      _playing = playerState.playing;
    });

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
    _player.pause();
    _player.dispose();
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

  Future<MediaItem> setMediaItem(int index) async {
    MediaItem mediaItem = queue[index];
    // IcyMetadata metaData = await _player.icyMetadataStream.last;
    // if (metaData.info.title != null) {
    //   mediaItem = MediaItem(
    //     id: mediaItem.id,
    //     album: mediaItem.album,
    //     title: metaData.info.title,
    //     artist: mediaItem.album,
    //     duration: mediaItem.duration,
    //     artUri: mediaItem.artUri,
    //   );
    // }

    return mediaItem;
  }
}
