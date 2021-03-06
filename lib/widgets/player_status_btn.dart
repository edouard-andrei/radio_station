import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlayerStatusBtn extends StatelessWidget {
  final double _iconSize;

  PlayerStatusBtn(this._iconSize);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlaybackState>(
      stream: AudioService.playbackStateStream,
      builder: (context, snapPlaybackState) {
        final playbackState = snapPlaybackState.data;
        if (playbackState == null) return Container();
        return InkWell(
          child: _getStatusWidget(playbackState),
          onTap: () {
            playbackState.playing ? AudioService.pause() : AudioService.play();
          },
        );
      },
    );
  }

  Widget _getStatusWidget(PlaybackState playbackState) {
    if (playbackState.processingState == AudioProcessingState.connecting ||
        playbackState.processingState == AudioProcessingState.buffering) {
      return CircularProgressIndicator(
        strokeWidth: 1.5,
      );
    }
    if (playbackState.playing) {
      return FaIcon(FontAwesomeIcons.pause, size: _iconSize);
    }
    return FaIcon(FontAwesomeIcons.play, size: _iconSize);
  }
}
