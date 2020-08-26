import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:radio_romania/widgets/playback_controlls.dart';
import 'package:radio_romania/widgets/playback_headers.dart';

class PlaybackController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AudioPlayer player = Provider.of<AudioPlayer>(context);

    return StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
      builder: (context, stream) =>
          stream.data?.processingState != ProcessingState.none
              ? Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        PlaybackHeaders(),
                        PlaybackControls(),
                      ],
                    ),
                  ),
                )
              : Container(),
    );
  }
}
