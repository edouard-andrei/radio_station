import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_romania/model/station.dart';
import 'package:radio_romania/screen/landing/radio_details.dart';
import 'package:radio_romania/widgets/playback_controller.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => new _LandingState();
}

class _LandingState extends State<Landing> {
  List<Station> _stations = [
    Station('assets/images/stations/kissfm.png', 'Kiss FM',
        'http://live.kissfm.ro:9128/kissfm.aacp'),
    Station('assets/images/stations/europafm.png', 'Europa FM',
        'http://astreaming.europafm.ro:8000/EuropaFM_aac'),
    Station('assets/images/stations/profm.png', 'Pro FM',
        'http://edge126.rdsnet.ro:84/profm/profm.mp3'),
    Station('assets/images/stations/radiozu.png', 'Radio ZU',
        'https://live7digi.antenaplay.ro/radiozu/radiozu-48000.m3u8'),
    Station('assets/images/stations/magicfm.png', 'Magic FM',
        'http://live.magicfm.ro:9128/magicfm.aacp'),
    Station('assets/images/stations/virgin.png', 'Virgin Radio Romania',
        'http://astreaming.virginradio.ro:8000/virgin_aacp_64k'),
    Station('assets/images/stations/onefm.png', 'One FM',
        'http://live.onefm.ro:9128/onefm.aacp'),
    Station('assets/images/stations/vibefm.png', 'Vibe FM',
        'http://astreaming.vibefm.ro:8000/vibefm_aacp48k'),
    Station('assets/images/stations/rockfm.png', 'Rock FM',
        'http://live.rockfm.ro:9128/rockfm.aacp'),
    Station('assets/images/stations/impuls.png', 'Impuls Radio',
        'https://live.radio-impuls.ro/stream')
  ];

  Station _currentPlayingStation;

  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    initPlaylist();
  }

  @override
  void dispose() {
    playerDispose();
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
          StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, stream) {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        stream.data.processingState.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ],
              );
            }
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _stations.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    playAudio(index);
                  },
                  child:
                      RadioListItem(_stations[index], _currentPlayingStation),
                );
              },
            ),
          ),
          _currentPlayingStation != null
              ? PlaybackController(
                  title: _currentPlayingStation.name,
                  volumeValue: 1.0,
                  player: player,
                )
              : Container()
        ],
      ),
    );
  }

  Future<void> initPlaylist() async {
    player.playerStateStream.listen((state) {
      print(state);
    });
    print('Player load OK');
    player.setLoopMode(LoopMode.all);
    print('Playlist loop all');
  }

  Future<void> playerDispose() async {
    await player.dispose();
    print('Player dispose OK');
  }

  void pauseAudio() {
    player.pause();
    setState(() {
      _currentPlayingStation = null;
    });
  }

  Future<void> playAudio(int index) async {
    final station = _stations[index];
    if (_currentPlayingStation == station) {
      pauseAudio();
      return;
    }
    print('Playing ' + station.name);
    await player.pause();
    player.setUrl(station.url);
    if (!player.playing) {
      player.play();
    }
    setState(() {
      _currentPlayingStation = station;
    });
  }
}
