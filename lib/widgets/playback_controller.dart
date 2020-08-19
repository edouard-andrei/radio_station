import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlaybackController extends StatelessWidget {
  final String title;
  final double volumeValue;
  final AudioPlayer player;
  final double _iconSize = 48;

  PlaybackController({Key key, this.title, this.volumeValue, this.player})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(title),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Icon(
                    Icons.skip_previous,
                    size: _iconSize,
                  ),
                ),
                InkWell(
                  child: player.playing
                      ? Icon(
                          Icons.pause,
                          size: _iconSize,
                        )
                      : Icon(
                          Icons.play_arrow,
                          size: _iconSize,
                        ),
                  onTap: () => {playPause()},
                ),
                InkWell(
                  child: Icon(
                    Icons.skip_next,
                    size: _iconSize,
                  ),
                ),
              ],
            ),
            Slider(
                divisions: 10,
                min: 0.0,
                max: 1.0,
                value: volumeValue ?? 1.0,
                onChanged: (value) {})
          ],
        ),
      ),
    );
  }

  playPause() {
    player.playing ? player.pause() : player.play();
  }
}
