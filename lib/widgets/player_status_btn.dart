import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class PlayerStatusBtn extends StatelessWidget {
  final double _iconSize;

  PlayerStatusBtn(this._iconSize);

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayer>(
      builder: (BuildContext context, player, Widget child) => InkWell(
        child: StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, stream) => _getStatusWidget(stream),
        ),
        onTap: () => {
          player.playing ? player.pause() : player.play(),
        },
      ),
    );
  }

  Widget _getStatusWidget(AsyncSnapshot<PlayerState> stream) {
    if (stream.data?.processingState == ProcessingState.buffering ||
        stream.data?.processingState == ProcessingState.loading) {
      return CircularProgressIndicator(
        strokeWidth: 2,
      );
    }
    if (stream.data != null ? stream.data.playing : false) {
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
