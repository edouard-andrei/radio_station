import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:radio_romania/widgets/player_status_btn.dart';

import '../main.dart';

class PlaybackControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _iconSize = 32;

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
              startService();
              AudioService.skipToPrevious();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: PlayerStatusBtn(_iconSize),
          ),
          InkWell(
            child: Icon(
              Icons.skip_next,
              size: _iconSize,
            ),
            onTap: () {
              startService();
              AudioService.skipToNext();
            },
          ),
        ],
      ),
    );
  }

}