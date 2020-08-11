import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './widgets/essentials.dart';
import './widgets/component_form.dart';
import '../../models/course.dart';
import '../../blocs/courses_bloc/courses_bloc.dart';

enum ComponentType { Lecture, Tutorial, Lab }

class AddCourseScreen extends StatelessWidget {
  static const routeName = '/add_course';
  final course = Course(
    name: '',
    nick: '',
    id: '',
    ic: '',
    units: 0,
    lecRoom: '',
    tutRoom: '',
    labRoom: '',
    lecturer: '',
    tutTeacher: '',
    labTeacher: '',
    lecTime: {'days': <String>[], 'time': <int>[]},
    tutTime: {'days': <String>[], 'time': <int>[]},
    labTime: {'days': <String>[], 'time': <int>[]},
    lecSec: '',
    tutSec: '',
    labSec: '',
    notes: <String>[],
    marks: <Map<String, String>>[],
  );
  final essentialsKey = GlobalKey<FormState>();
  final lecKey = GlobalKey<FormState>();
  final tutKey = GlobalKey<FormState>();
  final labKey = GlobalKey<FormState>();

  void addCourse(BuildContext context) {
    essentialsKey.currentState.save();
    lecKey.currentState.save();
    tutKey.currentState.save();
    labKey.currentState.save();
    BlocProvider.of<CoursesBloc>(context).add(CourseAdded(course));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Add Course',
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => addCourse(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              Essentials(essentialsKey, course),
              ComponentForm(lecKey, ComponentType.Lecture, course),
              ComponentForm(tutKey, ComponentType.Tutorial, course),
              ComponentForm(labKey, ComponentType.Lab, course),
            ],
          ),
        ),
      ),
    );
  }
}
