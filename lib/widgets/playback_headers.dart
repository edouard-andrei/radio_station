import 'package:audio_service/audio_service.dart';
import 'package:flutter/widgets.dart';

class PlaybackHeaders extends StatelessWidget {
  final bool vertical;

  PlaybackHeaders({this.vertical = false});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem>(
      stream: AudioService.currentMediaItemStream,
      builder: (context, stream) {
        return vertical
            ? Column(children: _details(stream))
            : Row(children: _details(stream));
      },
    );
  }

  List<Widget> _details(AsyncSnapshot<MediaItem> stream) {
    return [
      stream.data?.artUri != null
          ? ConstrainedBox(
              constraints: vertical
                  ? BoxConstraints.expand(height: 150, width: 150)
                  : BoxConstraints.expand(height: 100, width: 100),
              child: Image.asset(stream.data?.artUri ?? ''),
            )
          : Container(),
      stream.data?.artist != null ? Text(stream.data?.artist) : Container(),
    ];
  }
}
