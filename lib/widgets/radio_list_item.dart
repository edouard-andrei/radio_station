import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_romania/constants/stations.dart';
import 'package:radio_romania/model/current.dart';
import 'package:radio_romania/model/station.dart';

class RadioListItem extends StatelessWidget {
  final Station _station;

  RadioListItem(this._station);

  @override
  Widget build(BuildContext context) {
    return Consumer<Current>(
        builder: (BuildContext context, current, Widget child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 2.0,
            color: _station == stations[current.index]
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      this._station.logoPath,
                      fit: BoxFit.contain,
                      height: 48.0,
                    ),
                  ),
                ),
          ),
        ));
  }
}
