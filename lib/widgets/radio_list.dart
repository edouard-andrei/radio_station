import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:radio_romania/widgets/radio_list_item.dart';

class RadioList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, contraints) {
        return StreamBuilder<List<MediaItem>?>(
            stream: AudioService.queueStream,
            builder: (context, snapQueueStream) {
              if (snapQueueStream.connectionState != ConnectionState.active) {
                return Center(child: CircularProgressIndicator());
              }
              final queue = snapQueueStream.data;
              if (queue == null || queue.isEmpty) {
                return Center(child: Text("No radios available"));
              }
              return GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: _getAxisCount(contraints.maxWidth),
                children: [
                  ...queue.map((mediaItem) => RadioListItem(mediaItem)).toList()
                ],
              );
            });
      },
    );
  }

  int _getAxisCount(final double width) {
    if (width < 1280) {
      return 3;
    }
    if (width >= 1280 && width < 2560) {
      return 7;
    }
    return 12;
  }
}
