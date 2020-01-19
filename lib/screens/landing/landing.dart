import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radio_romania/screens/landing/radio_details.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RadioDetails('assets/images/kissfm.png', 'Kiss FM'),
          RadioDetails('assets/images/europafm.png', 'Europa FM'),
          RadioDetails('assets/images/profm.png', 'Pro FM'),
          RadioDetails('assets/images/radiozu.png', 'Radio ZU')
        ],
      ),
    );
  }

}