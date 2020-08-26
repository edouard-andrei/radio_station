import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:radio_romania/constants/stations.dart';
import 'package:radio_romania/model/current.dart';
import 'package:radio_romania/widgets/radio_list_item.dart';

class RadioList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AudioPlayer player = Provider.of<AudioPlayer>(context);
    Current current = Provider.of<Current>(context);

    return Expanded(
      child: OrientationBuilder(
        builder: (context, orientation) => GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 3 : 7,
          children: stations
              .map((station) => InkWell(
                    onTap: () =>
                        playAudio(player, stations.indexOf(station), current),
                    child: RadioListItem(station),
                  ))
              .toList(),
        ),
      ),
    );
  }

  void pauseAudio(AudioPlayer player) {
    player.pause();
  }

  void playAudio(AudioPlayer player, int stationIndex, Current current) {
    if (stationIndex == current.index) {
      pauseAudio(player);
      return;
    }
    player.seek(Duration(milliseconds: 0), index: stationIndex);
    current.index = stationIndex;
    if (!player.playing) {
      player.play();
    }
  }
}
