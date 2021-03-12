import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:radio_romania/widgets/playback_controls.dart';

class PlaybackView extends StatelessWidget {
  final double _smallThreshold = 0.15;
  final double _maxThreshold = 0.5;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
      stream: AudioService.currentMediaItemStream,
      builder: (context, snapMediaItem) {
        final mediaItem = snapMediaItem.data;
        if (mediaItem != null) {
          return LayoutBuilder(
            builder: (context, fullPageConstraints) {
              return Miniplayer(
                minHeight: fullPageConstraints.maxHeight * _smallThreshold,
                maxHeight: fullPageConstraints.maxHeight * _maxThreshold,
                elevation: 4.0,
                curve: Curves.ease,
                builder: (height, percentage) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 16.0, bottom: 16.0),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.lerp(Alignment.centerLeft,
                                Alignment.topCenter, percentage)!,
                            child: mediaItem.artUri != null
                                ? Image.asset(
                                    "${mediaItem.artUri}",
                                    width: lerpDouble(75, 150, percentage),
                                    fit: BoxFit.contain,
                                  )
                                : Container(),
                          ),
                          Align(
                            alignment: fullPageConstraints.maxWidth < 800
                                ? Alignment.lerp(Alignment.centerLeft,
                                    Alignment.center, percentage)!
                                : Alignment.lerp(Alignment.centerLeft,
                                    Alignment.center, percentage)!,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: lerpDouble(0, 72, percentage)!),
                              height: fullPageConstraints.maxHeight * 0.12,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.lerp(Alignment.center,
                                        Alignment.topCenter, percentage)!,
                                    child: StreamBuilder(
                                        stream: AudioService.customEventStream,
                                        builder: (context, snapIcyMetadata) {
                                          final icyMetadata =
                                              snapIcyMetadata.data;
                                          return LayoutBuilder(
                                              builder: (context, constraints) {
                                            return Container(
                                              width: lerpDouble(
                                                  constraints.maxWidth / 3,
                                                  constraints.maxWidth,
                                                  percentage),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(snapMediaItem
                                                          .data?.artist ??
                                                      ''),
                                                  if (icyMetadata != null &&
                                                      icyMetadata
                                                          is IcyMetadata)
                                                    if (icyMetadata.info !=
                                                            null &&
                                                        icyMetadata
                                                                .info!.title !=
                                                            null &&
                                                        icyMetadata.info!.title!
                                                            .isNotEmpty)
                                                      Text(
                                                        icyMetadata
                                                            .info!.title!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )
                                                    else
                                                      Container()
                                                ],
                                              ),
                                            );
                                          });
                                        }),
                                  ),
                                  Align(
                                    alignment: Alignment.lerp(
                                        Alignment.centerRight,
                                        Alignment.bottomCenter,
                                        percentage)!,
                                    child: PlaybackControls(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
