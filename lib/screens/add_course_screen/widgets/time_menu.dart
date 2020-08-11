import 'package:flutter/material.dart';

import '../add_course_screen.dart';
import '../../../models/course.dart';

class TimeMenu extends StatefulWidget {
  final Course _course;
  final ComponentType _type;

  TimeMenu(this._course, this._type);
  @override
  _TimeMenuState createState() => _TimeMenuState();
}

class _TimeMenuState extends State<TimeMenu> {
  List<int> timesList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  int timeCalc(int slot) => slot > 5 ? slot - 5 : slot + 7;

  List<bool> valList = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  String key;

  @override
  void initState() {
    key = typeToKey(widget._type);
    super.initState();
    if (widget._type == ComponentType.Lecture) {
      for (int i = 0; i < 10; i++) {
        if (widget._course.lecTime['time'].contains(timesList[i])) {
          valList[i] = true;
        }
      }
    } else if (widget._type == ComponentType.Tutorial) {
      for (int i = 0; i < 10; i++) {
        if (widget._course.tutTime['time'].contains(timesList[i])) {
          valList[i] = true;
        }
      }
    } else {
      for (int i = 0; i < 10; i++) {
        if (widget._course.labTime['time'].contains(timesList[i])) {
          valList[i] = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: Colors.black,
      ),
      child: SimpleDialog(
        title: Text(
          'Time',
          style: Theme.of(context).textTheme.headline5.copyWith(
                color: Colors.black,
              ),
        ),
        children: timesList
            .map((time) => CheckboxListTile(
                  title: Text(
                    '${timeCalc(time)}',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  value: valList[time - 1],
                  onChanged: (val) {
                    setState(() {
                      valList[timesList.indexOf(time)] = val;
                    });
                    if (widget._type == ComponentType.Lecture) {
                      val
                          ? widget._course.lecTime['time'].add(time)
                          : widget._course.lecTime['time'].remove(time);
                    } else if (widget._type == ComponentType.Tutorial) {
                      val
                          ? widget._course.tutTime['time'].add(time)
                          : widget._course.tutTime['time'].remove(time);
                    } else {
                      val
                          ? widget._course.labTime['time'].add(time)
                          : widget._course.labTime['time'].remove(time);
                    }
                  },
                ))
            .toList(),
      ),
    );
  }

  String typeToKey(ComponentType type) {
    if (type == ComponentType.Lecture) {
      return 'lecTime';
    } else if (type == ComponentType.Tutorial) {
      return 'tutTime';
    } else {
      return 'labTime';
    }
  }
}
