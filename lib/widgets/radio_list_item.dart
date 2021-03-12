import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

class RadioListItem extends StatelessWidget {
  final MediaItem _station;

  RadioListItem(this._station);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
      stream: AudioService.currentMediaItemStream,
      builder: (context, stream) {
        return Material(
          elevation: 2.0,
          color: _station == stream.data
              ? Theme.of(context).primaryColor
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () async {
              await AudioService.skipToQueueItem(_station.id);
            },
            child: Container(
              child: LayoutBuilder(
                builder: (_, constraints) {
                  return Padding(
                    padding: EdgeInsets.all(constraints.maxWidth / 8),
                    child: Image.asset(
                      this._station.artUri!.path,
                      fit: BoxFit.contain,
                      height: 48.0,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
