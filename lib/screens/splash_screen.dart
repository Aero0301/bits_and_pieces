import 'package:flutter/material.dart';

import '../widgets/logo.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: 'logo',
            child: Logo(120),
          ),
        ],
      ),
    );
  }
}
