import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:radio_romania/constants/stations.dart';
import 'package:radio_romania/widgets/radio_list_item.dart';

class RadioList extends StatelessWidget {
  final MediaLibrary _mediaLibrary = MediaLibrary();

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 3 : 7,
          children: _mediaLibrary.stations.map((station) {
            return RadioListItem(station);
          }).toList(),
        );
      },
    );
  }
}
