import 'package:flutter/material.dart';

class Logo extends StatelessWidget {

  final double bitsSize;

  Logo(this.bitsSize);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'BITS',
          style: Theme.of(context).textTheme.headline5.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: bitsSize,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'AND',
          style: Theme.of(context).textTheme.headline5.copyWith(
            color: Theme.of(context).accentColor,
            fontSize: bitsSize / 2,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'PIECES',
          style: Theme.of(context).textTheme.headline5.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: bitsSize,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
