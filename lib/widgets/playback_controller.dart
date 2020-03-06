import 'package:flutter/material.dart';

class PlaybackController extends StatelessWidget {
  final String title;
  final bool isPlaying;
  final double volumeValue;

  PlaybackController({Key key, this.title, this.isPlaying, this.volumeValue})
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
                Icon(Icons.skip_previous),
                isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                Icon(Icons.skip_next),
              ],
            ),
            Slider(
                divisions: 20,
                min: 0.0,
                max: 2.0,
                value: volumeValue ?? 1.0,
                onChanged: (value) {

                })
          ],
        ),
      ),
    );
  }
}
