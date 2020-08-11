import 'package:flutter/material.dart';

import '../add_course_screen.dart';
import '../../../models/course.dart';

class DaysMenu extends StatefulWidget {
  final Course _course;
  final ComponentType _type;

  DaysMenu(this._course, this._type);
  @override
  _DaysMenuState createState() => _DaysMenuState();
}

class _DaysMenuState extends State<DaysMenu> {
  List<String> daysList = ['M', 'T', 'W', 'Th', 'F', 'S'];

  List<bool> valList = [false, false, false, false, false, false];

  String key;

  @override
  void initState() {
    super.initState();
    if (widget._type == ComponentType.Lecture) {
      for (int i = 0; i < 6; i++) {
        if (widget._course.lecTime['days'].contains(daysList[i])) {
          valList[i] = true;
        }
      }
    } else if (widget._type == ComponentType.Tutorial) {
      for (int i = 0; i < 6; i++) {
        if (widget._course.tutTime['days'].contains(daysList[i])) {
          valList[i] = true;
        }
      }
    } else {
      for (int i = 0; i < 6; i++) {
        if (widget._course.labTime['days'].contains(daysList[i])) {
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
          'Days',
          style: Theme.of(context).textTheme.headline5.copyWith(
                color: Colors.black,
              ),
        ),
        children: daysList
            .map((day) => CheckboxListTile(
                  title: Text(
                    day,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  value: valList[daysList.indexOf(day)],
                  onChanged: (val) {
                    setState(() {
                      valList[daysList.indexOf(day)] = val;
                    });
                    if (widget._type == ComponentType.Lecture) {
                      val
                          ? widget._course.lecTime['days'].add(day)
                          : widget._course.lecTime['days'].remove(day);
                    } else if (widget._type == ComponentType.Tutorial) {
                      val
                          ? widget._course.tutTime['days'].add(day)
                          : widget._course.tutTime['days'].remove(day);
                    } else {
                      val
                          ? widget._course.labTime['days'].add(day)
                          : widget._course.labTime['days'].remove(day);
                    }
                  },
                ))
            .toList(),
      ),
    );
  }
}
