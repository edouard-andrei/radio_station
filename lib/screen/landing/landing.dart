import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'package:radio_romania/model/station.dart';
import 'package:radio_romania/screen/landing/radio_details.dart';
import 'package:radio_romania/widgets/playback_controller.dart';

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
    Station('assets/images/stations/virgin.png', 'Virgin', 'http://astreaming.virginradio.ro:8000/virgin_aacp_64k'),
    Station('assets/images/stations/onefm.png', 'One FM', 'http://live.onefm.ro:9128/onefm.aacp'),
    Station('assets/images/stations/vibefm.png', 'Vibe FM', 'http://astreaming.vibefm.ro:8000/vibefm_aacp48k'),
    Station('assets/images/stations/rockfm.png', 'Rock FM', 'http://live.rockfm.ro:9128/rockfm.aacp')
  ];

  Station _currentPlayingStation;

  @override
  void initState() {
    super.initState();
    audioStart();
    AudioService.connect();
  }

  @override
  void dispose() {
    audioStop();
    AudioService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Romanian Radio Stations'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _stations.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    if (_currentPlayingStation == _stations[index]) {
                      pauseAudio();
                    } else {
                      playAudio(index);
                    }
                  },
                  child: RadioListItem(_stations[index]),
                );
              },
            ),
          ),
          _currentPlayingStation != null
              ? PlaybackController(
                  title: _currentPlayingStation.name,
                  isPlaying: false,
                  volumeValue: 1.0,
                )
              : Container()
        ],
      ),
    );
  }

  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
    print('Audio Start OK');
  }

  Future<void> audioStop() async {
    await FlutterRadio.stop();
    print('Audio STOP OK');
  }

  void pauseAudio() {
    FlutterRadio.pause(url: _currentPlayingStation.url);
    AudioService.pause();
    setState(() {
      _currentPlayingStation = null;
    });
  }

  Future<void> playAudio(int index) async {
    if(_currentPlayingStation != null) {
      FlutterRadio.pause(url: _currentPlayingStation.url);
      setState(() {
        _currentPlayingStation = null;
      });
    } else {
      await AudioService.start(
        backgroundTaskEntrypoint: myBackgroundTaskEntrypoint,
        androidNotificationChannelName: 'Music Player',
        androidNotificationIcon: "mipmap/ic_launcher",
      );
    }
    FlutterRadio.play(url: _stations[index].url);
    AudioService.play();
    setState(() {
      _currentPlayingStation = _stations[index];
    });
  }

  void myBackgroundTaskEntrypoint() {
    AudioServiceBackground.run(() => MyBackgroundTask());
  }
}

class MyBackgroundTask extends BackgroundAudioTask {
  @override
  Future<void> onStart() {
    throw UnimplementedError();
  }


  @override
  void onPause() {

  }

  @override
  void onStop() {
    // TODO: implement onStop
  }

  @override
  void onAudioBecomingNoisy() {
    onPause();
  }
}
