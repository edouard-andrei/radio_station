import 'package:flutter/material.dart';
import 'package:radio_romania/widgets/playback_controls.dart';
import 'package:radio_romania/widgets/playback_headers.dart';

class PlaybackController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
