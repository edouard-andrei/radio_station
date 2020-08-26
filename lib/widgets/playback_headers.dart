import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:radio_romania/constants/stations.dart';
import 'package:radio_romania/model/current.dart';

class PlaybackHeaders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AudioPlayer player = Provider.of<AudioPlayer>(context);
    Current current = Provider.of<Current>(context);

    return Column(
      children: [
        Text(stations[current.index].name ?? ''),
        StreamBuilder<IcyMetadata>(
          stream: player.icyMetadataStream,
          builder: (context, stream) => stream?.data?.info?.title != null &&
                  stream.data.info.title.length > 0
              ? Text(stream.data?.info?.title.toString())
              : Container(),
        ),
      ],
    );
  }
}
