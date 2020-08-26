import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:radio_romania/constants/stations.dart';
import 'package:radio_romania/model/current.dart';
import 'package:radio_romania/screen/landing.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          Provider(
            create: (BuildContext context) => AudioPlayer(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => Current(),
          )
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AudioPlayer player = Provider.of<AudioPlayer>(context);
    initPlayer(player);
    return MaterialApp(
      title: 'Radio Romania',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: Landing(),
    );
  }

  Future<void> initPlayer(AudioPlayer player) async {
    await player.load(
      LoopingAudioSource(
        count: stations.length,
        child: ConcatenatingAudioSource(
          children: stations
              .map((station) => AudioSource.uri(Uri.parse(station.url)))
              .toList(),
        ),
      ),
    );
  }
}
