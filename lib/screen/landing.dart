import 'package:flutter/material.dart';
import 'package:radio_romania/widgets/playback_controller.dart';
import 'package:radio_romania/widgets/radio_list.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radio Stations'),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: <Widget>[RadioList(), PlaybackController()],
        ),
      ),
    );
  }
}
