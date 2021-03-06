import 'package:audio_service/audio_service.dart';
import 'package:flutter/widgets.dart';

class PlaybackHeaders extends StatelessWidget {
  final bool vertical;

  PlaybackHeaders({this.vertical = false});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
      stream: AudioService.currentMediaItemStream,
      builder: (context, stream) {
        return vertical
            ? Column(children: _details(stream.data))
            : Row(children: _details(stream.data));
      },
    );
  }

  List<Widget> _details(MediaItem? mediaItem) {
    return [
      mediaItem!.artUri?.path != null
          ? ConstrainedBox(
              constraints: vertical
                  ? BoxConstraints.expand(height: 150, width: 150)
                  : BoxConstraints.expand(height: 100, width: 100),
              child: Image.asset(mediaItem.artUri?.path ?? ''),
            )
          : Container(),
      mediaItem.artist != null ? Text(mediaItem.artist!) : Container(),
    ];
  }
}
