import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:radio_romania/widgets/playback_view.dart';
import 'package:radio_romania/widgets/radio_list.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
          stream: AudioService.runningStream,
          builder: (context, snapRunningStream) {
            if (snapRunningStream.connectionState != ConnectionState.active) {
              return Container();
            }
            final running = snapRunningStream.data ?? false;
            return Stack(
              children: [
                Column(
                  children: [
                    AppBar(
                      title: Text('Radio Stations'),
                    ),
                    Expanded(
                      child: RadioList(),
                    ),
                  ],
                ),
                if (running) PlaybackView(),
              ],
            );
          }),
    );
  }
}
