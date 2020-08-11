import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  final String _id;
  final String _ic;
  final int _units;

  Info(this._id, this._ic, this._units);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _id,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Info',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black,
                      ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          'ID: $_id',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.black,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Units: $_units',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.black,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('IC: $_ic',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.black,
                          )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
