import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:radio_romania/audio_player_task.dart';
import 'package:radio_romania/screen/landing.dart';

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    if (!AudioService.connected) {
      AudioService.connect();
    }
    startService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radio Romania',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: AudioServiceWidget(
        child: Landing(),
      ),
    );
  }

  @override
  Future<void> reassemble() async {
    await AudioService.stop();
    await startService();
    super.reassemble();
  }

  @override
  void dispose() {
    AudioService.disconnect();
    super.dispose();
  }
}

Future<void> startService() async {
  await AudioService.start(
    backgroundTaskEntrypoint: _backgroundTaskEntrypoint,
    androidEnableQueue: true,
    androidNotificationChannelName: 'Player',
    androidNotificationChannelDescription: 'Player media controls',
    androidStopForegroundOnPause: true,
  );
}

void _backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}
