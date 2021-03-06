import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:radio_romania/widgets/player_status_btn.dart';

class PlaybackControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _iconSize = 28;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            child: FaIcon(FontAwesomeIcons.stepBackward, size: _iconSize),
            onTap: () {
              AudioService.skipToPrevious();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: PlayerStatusBtn(_iconSize),
          ),
          InkWell(
            child: FaIcon(FontAwesomeIcons.stepForward, size: _iconSize),
            onTap: () {
              AudioService.skipToNext();
            },
          ),
        ],
      ),
    );
  }

}