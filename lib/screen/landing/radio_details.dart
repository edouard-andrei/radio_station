import 'package:flutter/material.dart';
import 'package:radio_romania/model/station.dart';

class RadioListItem extends StatelessWidget {
  final Station _station;

  RadioListItem(this._station);

  @override
  Widget build(BuildContext context) {
    return Row(
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
//                  Image.asset(
//                    this._station.logoPath,
//                    fit: BoxFit.contain,
//                    width: 48.0,
//                    height: 48.0,
//                  )
            ],
          ),
        ),
        Text(this._station.name)
      ],
    );
  }
}
