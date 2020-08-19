import 'package:flutter/material.dart';
import 'package:radio_romania/model/station.dart';

class RadioListItem extends StatelessWidget {
  final Station _station;
  final Station _currentPlayingStation;

  RadioListItem(this._station, this._currentPlayingStation);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 16.0),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: Stack(
              children: <Widget>[
                Image.asset(
                  this._station.logoPath,
                  fit: BoxFit.contain,
                  width: 48.0,
                  height: 48.0,
                ),
              ],
            ),
          ),
          Text(this._station.name),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          _station == _currentPlayingStation ? Icon(Icons.play_arrow) : Container(),
        ],
      ),
    );
  }
}
