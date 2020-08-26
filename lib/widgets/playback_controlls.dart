import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:radio_romania/model/current.dart';
import 'package:radio_romania/widgets/player_status_btn.dart';

class PlaybackControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _iconSize = 32;

    AudioPlayer player = Provider.of<AudioPlayer>(context);
    Current current = Provider.of<Current>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            child: Icon(
              Icons.skip_previous,
              size: _iconSize,
            ),
            onTap: () {
              player.seekToPrevious();
              if (player.hasPrevious) {
                current.index--;
              }
            },
          ),
          PlayerStatusBtn(_iconSize),
          InkWell(
            child: Icon(
              Icons.skip_next,
              size: _iconSize,
            ),
            onTap: () {
              player.seekToNext();
              if (player.hasNext) {
                current.index++;
              }
            },
          ),
        ],
      ),
    );
  }

}