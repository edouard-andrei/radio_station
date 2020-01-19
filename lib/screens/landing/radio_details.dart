import 'package:flutter/material.dart';

class RadioDetails extends StatelessWidget {
  final String _logoPath;
  final String _name;

  RadioDetails(this._logoPath, this._name);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(
                this._logoPath,
                fit: BoxFit.cover,
                width: 48.0,
                height: 48.0,
              ),
            ),
            Text(this._name)
          ],
        ),
      ),
    );
  }
}
