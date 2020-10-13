import 'package:flutter/material.dart';
import 'package:radio_romania/widgets/playback_view.dart';
import 'package:radio_romania/widgets/radio_list.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radio Stations'),
      ),
      body: Stack(
        children: [
          RadioList(),
          PlaybackView(),
        ],
      ),
    );
  }
}
