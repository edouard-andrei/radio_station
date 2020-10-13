import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:radio_romania/widgets/playback_controls.dart';
import 'package:radio_romania/widgets/playback_headers.dart';

class PlaybackView extends StatelessWidget {
  final double transitionThreshold = 0.5;
  final double smallThreshold = 0.15;
  final double maxThreshold = 0.5;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Miniplayer(
          minHeight: constraints.maxHeight * smallThreshold,
          maxHeight: constraints.maxHeight * maxThreshold,
          elevation: 4.0,
          curve: Curves.ease,
          builder: (height, percentage) {
            bool small = percentage <= transitionThreshold;
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: small
                    ? smallPlayer(
                  percentageFromValueInRange(
                      min: 0.5, max: 0, value: percentage),
                )
                    : largePlayer(
                  percentageFromValueInRange(
                      min: 0.5, max: 1, value: percentage),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget largePlayer(double opacity) {
    return Opacity(
      opacity: opacity,
      child: Column(
        children: [
          PlaybackHeaders(vertical: true),
          Expanded(child: PlaybackControls()),
        ],
      ),
    );
  }

  Widget smallPlayer(double opacity) {
    return Opacity(
      opacity: opacity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PlaybackHeaders(),
          PlaybackControls(),
        ],
      ),
    );
  }

  // Calculates the percentage of a value within a given range of values
  double percentageFromValueInRange(
      {@required final double min,
      @required final max,
      @required final value}) {
    return (value - min) / (max - min);
  }
}
