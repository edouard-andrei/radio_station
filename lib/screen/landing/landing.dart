import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'package:radio_romania/model/station.dart';
import 'package:radio_romania/screen/landing/radio_details.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => new _LandingState();
}

class _LandingState extends State<Landing> {
  List<Station> _stations = [
    Station('assets/images/stations/kissfm.png', 'Kiss FM', 'http://live.kissfm.ro:9128/kissfm.aacp'),
    Station('assets/images/stations/europafm.png', 'Europa FM', 'http://astreaming.europafm.ro:8000/EuropaFM_aac'),
    Station('assets/images/stations/profm.png', 'Pro FM', 'http://edge126.rdsnet.ro:84/profm/profm.mp3'),
    Station('assets/images/stations/radiozu.png', 'Radio ZU', 'https://live2ro.antenaplay.ro/radiozu/radiozu-48000.m3u8'),
    Station('assets/images/stations/magicfm.png', 'Magic FM', 'http://live.magicfm.ro:9128/magicfm.aacp'),
    Station('assets/images/stations/virgin.png', 'Virgin', 'http://astreaming.virginradio.ro:8000/virgin_aacp_64k.m3u'),
    Station('assets/images/stations/onefm.png', 'One FM', 'http://live.onefm.ro:9128/onefm.aacp'),
    Station('assets/images/stations/vibefm.png', 'Vibe FM', 'http://astreaming.vibefm.ro:8000/vibefm_aacp48k.m3u'),
    Station('assets/images/stations/rockfm.png', 'Rock FM', 'http://live.rockfm.ro:9128/rockfm.aacp')
  ];

  @override
  void initState() {
    super.initState();
    audioStart();
  }

  @override
  void dispose() {
    audioStop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Station _currentPlayingStation;

    return Scaffold(
      appBar: AppBar(
        title: Text('Romanian Radio Stations'),
      ),
      body: new ListView.builder(
        itemCount: _stations.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () async {
              print("Tapped on ${_stations[index].name}");
              if (await FlutterRadio.isPlaying()) {
                if (_currentPlayingStation == _stations[index]) {
                  FlutterRadio.pause(url: _currentPlayingStation.url);
                  _currentPlayingStation = null;
                } else {
                  FlutterRadio.pause(url: _currentPlayingStation.url);
                  FlutterRadio.play(url: _stations[index].url);
                  _currentPlayingStation = _stations[index];
                }
              } else {
                FlutterRadio.play(url: _stations[index].url);
                _currentPlayingStation = _stations[index];
              }
            },
            child: new RadioListItem(_stations[index]),
          );
        },
      ),
    );
  }

  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
    FlutterRadio.setVolume(100.0);
    print('Audio Start OK');
  }

  Future<void> audioStop() async {
    await FlutterRadio.stop();
    print('Audio STOP OK');
  }
}
