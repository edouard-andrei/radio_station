import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:radio_romania/widgets/playback_controls.dart';

class PlaybackView extends StatelessWidget {
  final double _smallThreshold = 0.15;
  final double _maxThreshold = 0.5;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Miniplayer(
          minHeight: constraints.maxHeight * _smallThreshold,
          maxHeight: constraints.maxHeight * _maxThreshold,
          elevation: 4.0,
          curve: Curves.ease,
          builder: (height, percentage) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: StreamBuilder(
                  stream: AudioService.currentMediaItemStream,
                  builder: (_, mediaItem) {
                    return Stack(
                      children: [
                        Align(
                          alignment: Alignment.lerp(Alignment.centerLeft,
                              Alignment.topCenter, percentage),
                          child: mediaItem.data?.artUri != null
                              ? Image.asset(
                                  mediaItem.data?.artUri,
                                  width: lerpDouble(75, 150, percentage),
                                )
                              : Container(),
                        ),
                        Align(
                          alignment: constraints.maxWidth < 800
                              ? Alignment.lerp(Alignment.centerLeft,
                                  Alignment.center, percentage)
                              : Alignment.lerp(Alignment.centerLeft,
                                  Alignment.center, percentage),
                          child: Container(
                            margin: EdgeInsets.only(top: lerpDouble(0, 48, percentage)),
                            height: constraints.maxHeight * 0.1,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.lerp(Alignment.center,
                                      Alignment.topCenter, percentage),
                                  child: Text(mediaItem.data?.artist ?? ''),
                                ),
                                Align(
                                  alignment: Alignment.lerp(
                                      Alignment.centerRight,
                                      Alignment.bottomCenter,
                                      percentage),
                                  child: PlaybackControls(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
