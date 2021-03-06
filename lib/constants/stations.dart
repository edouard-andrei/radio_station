import 'package:audio_service/audio_service.dart';

class MediaLibrary {
  final _stations = [
    MediaItem(
      id: "http://live.kissfm.ro:9128/kissfm.aacp",
      album: "Kiss FM",
      title: "Kiss FM",
      artist: "Kiss FM",
      duration: Duration.zero,
      artUri: Uri(path: "assets/images/stations/kissfm.png"),
    ),
    MediaItem(
      id: "http://astreaming.europafm.ro:8000/EuropaFM_aac",
      album: "Europa FM",
      title: "Europa FM",
      artist: "Europa FM",
      duration: Duration.zero,
      artUri: Uri(path: "assets/images/stations/europafm.png"),
    ),
    MediaItem(
      id: "http://edge126.rdsnet.ro:84/profm/profm.mp3",
      album: "Pro FM",
      title: "Pro FM",
      artist: "Pro FM",
      duration: Duration.zero,
      artUri: Uri(path: "assets/images/stations/profm.png"),
    ),
    MediaItem(
      id: "https://live7digi.antenaplay.ro/radiozu/radiozu-48000.m3u8",
      album: "Radio ZU",
      title: "Radio ZU",
      artist: "Radio ZU",
      duration: Duration.zero,
      artUri: Uri(path: "assets/images/stations/radiozu.png"),
    ),
    MediaItem(
      id: "http://live.magicfm.ro:9128/magicfm.aacp",
      album: "Magic FM",
      title: "Magic FM",
      artist: "Magic FM",
      duration: Duration.zero,
      artUri: Uri(path: "assets/images/stations/magicfm.png"),
    ),
    MediaItem(
      id: "http://astreaming.virginradio.ro:8000/virgin_aacp_64k",
      album: "Virgin Radio Romania",
      title: "Virgin Radio Romania",
      artist: "Virgin Radio Romania",
      duration: Duration.zero,
      artUri: Uri(path: "assets/images/stations/virgin.png"),
    ),
    MediaItem(
      id: "http://live.onefm.ro:9128/onefm.aacp",
      album: "One FM",
      title: "One FM",
      artist: "One FM",
      duration: Duration.zero,
      artUri: Uri(path: "assets/images/stations/onefm.png"),
    ),
    MediaItem(
      id: "http://astreaming.vibefm.ro:8000/vibefm_aacp48k",
      album: "Vibe FM",
      title: "Vibe FM",
      artist: "Vibe FM",
      duration: Duration.zero,
      artUri: Uri(path: "assets/images/stations/vibefm.png"),
    ),
    MediaItem(
      id: "http://live.rockfm.ro:9128/rockfm.aacp",
      album: "Rock FM",
      title: "Rock FM",
      artist: "Rock FM",
      duration: Duration.zero,
      artUri: Uri(path: "assets/images/stations/rockfm.png"),
    ),
    MediaItem(
      id: "https://live.radio-impuls.ro/stream",
      album: "Impuls Radio",
      title: "Impuls Radio",
      artist: "Impuls Radio",
      duration: Duration.zero,
      artUri: Uri(path: "assets/images/stations/impuls.png"),
    ),
    MediaItem(
      id: "https://streamer.radio.co/s2c3cc784b/listen",
      album: "Electro Swing Radio",
      title: "Electro Swing Radio",
      artist: "Electro Swing Radio",
      duration: Duration.zero,
      artUri: Uri(path: "assets/images/stations/electro-swing.png"),
    )
  ];

  List<MediaItem> get stations => _stations;
}

// final List<Station> stations = [
//   Station('assets/images/stations/kissfm.png', 'Kiss FM',
//       'http://live.kissfm.ro:9128/kissfm.aacp'),
//   Station('assets/images/stations/europafm.png', 'Europa FM',
//       'http://astreaming.europafm.ro:8000/EuropaFM_aac'),
//   Station('assets/images/stations/profm.png', 'Pro FM',
//       'http://edge126.rdsnet.ro:84/profm/profm.mp3'),
//   Station('assets/images/stations/radiozu.png', 'Radio ZU',
//       'https://live7digi.antenaplay.ro/radiozu/radiozu-48000.m3u8'),
//   Station('assets/images/stations/magicfm.png', 'Magic FM',
//       'http://live.magicfm.ro:9128/magicfm.aacp'),
//   Station('assets/images/stations/virgin.png', 'Virgin Radio Romania',
//       'http://astreaming.virginradio.ro:8000/virgin_aacp_64k'),
//   Station('assets/images/stations/onefm.png', 'One FM',
//       'http://live.onefm.ro:9128/onefm.aacp'),
//   Station('assets/images/stations/vibefm.png', 'Vibe FM',
//       'http://astreaming.vibefm.ro:8000/vibefm_aacp48k'),
//   Station('assets/images/stations/rockfm.png', 'Rock FM',
//       'http://live.rockfm.ro:9128/rockfm.aacp'),
//   Station('assets/images/stations/impuls.png', 'Impuls Radio',
//       'https://live.radio-impuls.ro/stream'),
// ];

