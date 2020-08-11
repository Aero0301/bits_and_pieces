import 'package:flutter/material.dart';

import '../add_course_screen.dart';
import './days_menu.dart';
import './time_menu.dart';
import '../../../models/course.dart';

class ComponentForm extends StatefulWidget {
  final GlobalKey<FormState> _key;

  final ComponentType type;

  final Course course;

  ComponentForm(this._key, this.type, this.course);

  @override
  _ComponentFormState createState() => _ComponentFormState();
}

class _ComponentFormState extends State<ComponentForm> {
  final _sectionNode = FocusNode();

  final _roomNode = FocusNode();

  @override
  void dispose() {
    _sectionNode.dispose();
    _roomNode.dispose();
    super.dispose();
  }

  void showDaysDialog(BuildContext context) {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    showDialog(
      context: context,
      builder: (context) => DaysMenu(widget.course, widget.type),
    ).then((_) => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus());
  }
  void showTimeDialog(BuildContext context) {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    showDialog(
      context: context,
      builder: (context) => TimeMenu(widget.course, widget.type),
    ).then((_) => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: widget._key,
          child: Column(
            children: [
              Text(
                widget.type == ComponentType.Lecture
                    ? 'Lecture'
                    : (widget.type == ComponentType.Tutorial
                        ? 'Tutorial'
                        : 'Lab'),
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.black,
                    ),
              ),
              Divider(),
              TextFormField(
                decoration: InputDecoration(
                  labelText: widget.type == ComponentType.Lecture
                      ? 'Lecturer'
                      : 'Instructor',
                ),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.black,
                    ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_sectionNode),
                onSaved: (val) {
                  if (widget.type == ComponentType.Lecture) {
                    widget.course.lecturer = val;
                  } else if (widget.type == ComponentType.Tutorial) {
                    widget.course.tutTeacher = val;
                  } else {
                    widget.course.labTeacher = val;
                  }
                },
              ),
              TextFormField(
                focusNode: _sectionNode,
                decoration: InputDecoration(
                  labelText: 'Section',
                ),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.black,
                    ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_roomNode),
                onSaved: (val) {
                  if (widget.type == ComponentType.Lecture) {
                    widget.course.lecSec = val;
                  } else if (widget.type == ComponentType.Tutorial) {
                    widget.course.tutSec = val;
                  } else {
                    widget.course.labSec = val;
                  }
                },
              ),
              TextFormField(
                focusNode: _roomNode,
                decoration: InputDecoration(
                  labelText: 'Room',
                ),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.black,
                    ),
                onFieldSubmitted: (_) => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
                onSaved: (val) {
                  if (widget.type == ComponentType.Lecture) {
                    widget.course.lecRoom = val;
                  } else if (widget.type == ComponentType.Tutorial) {
                    widget.course.tutRoom = val;
                  } else {
                    widget.course.labRoom = val;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () => showDaysDialog(context),
                    textColor: Colors.white,
                    child: Text(
                      'Days',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () => showTimeDialog(context),
                    textColor: Colors.white,
                    child: Text(
                      'Time',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
