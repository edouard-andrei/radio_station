import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:radio_romania/constants/stations.dart';
import 'package:radio_romania/main.dart';
import 'package:radio_romania/widgets/radio_list_item.dart';

class RadioList extends StatelessWidget {
  final MediaLibrary _mediaLibrary = MediaLibrary();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 3 : 7,
            children: _mediaLibrary.stations
                .map((station) => InkWell(
                      onTap: () {
                        startService();
                        AudioService.skipToQueueItem(station.id);
                      },
                      child: RadioListItem(station),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
