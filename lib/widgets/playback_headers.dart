import 'package:audio_service/audio_service.dart';
import 'package:flutter/widgets.dart';

class PlaybackHeaders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem>(
      stream: AudioService.currentMediaItemStream,
      builder: (context, stream) {
        return Column(
          children: [
            Text(stream.data?.title ?? ''),
            stream.data?.artist != stream.data?.title
                ? Text(stream.data?.artist)
                : Container(),
          ],
        );
      },
    );
  }
}
