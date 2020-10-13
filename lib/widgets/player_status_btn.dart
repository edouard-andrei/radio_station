import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:radio_romania/main.dart';

class PlayerStatusBtn extends StatelessWidget {
  final double _iconSize;

  PlayerStatusBtn(this._iconSize);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlaybackState>(
      stream: AudioService.playbackStateStream,
      builder: (context, stream) => InkWell(
        child: _getStatusWidget(stream),
        onTap: () {
          startService();
          if (stream.data?.playing ?? false) {
            AudioService.pause();
          } else {
            AudioService.play();
          }
        },
      ),
    );
  }

  Widget _getStatusWidget(AsyncSnapshot<PlaybackState> stream) {
    if (stream.data?.processingState == AudioProcessingState.connecting ||
        stream.data?.processingState == AudioProcessingState.buffering) {
      return CircularProgressIndicator(
        strokeWidth: 2.5,
      );
    }
    if (stream.data?.playing ?? false) {
      return Icon(
        Icons.pause,
        size: _iconSize,
      );
    }
    return Icon(
      Icons.play_arrow,
      size: _iconSize,
    );
  }
}
