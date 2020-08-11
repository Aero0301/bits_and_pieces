import 'package:flutter/material.dart';

import '../course_detail_screen.dart';

class ComponentDetail extends StatelessWidget {
  final String _teacher;
  final String _room;
  final String _sec;
  final Map<String, dynamic> _time;
  final ComponentType _type;

  ComponentDetail(this._teacher, this._room, this._sec, this._time, this._type);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              _type == ComponentType.Lecture
                  ? 'Lecture'
                  : (_type == ComponentType.Tutorial ? 'Tutorial' : 'Lab'),
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
                    flex: 2,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${_type == ComponentType.Lecture ? 'Lecturer' : 'Instructor'}: $_teacher',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.black,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Room: $_room',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.black,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Section: $_sec',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.black,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Time: ${_time['days'].toString()} ${_time['time'].toString()}',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.black,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
