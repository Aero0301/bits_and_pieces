import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/navigation_bloc/navigation_bloc.dart';
import '../../blocs/courses_bloc/courses_bloc.dart';
import './widgets/info.dart';
import './widgets/component_detail.dart';
import './widgets/notes.dart';
import './widgets/marks.dart';

enum ComponentType { Lecture, Tutorial, Lab }

class CourseDetailScreen extends StatelessWidget {
  static const routeName = '/course_detail_screen';

  void showDeleteDialog(BuildContext context, String courseId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Delete Course',
            style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.black,
                ),
          ),
          content: Text(
            'Are you sure you want to delete the course?',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.black,
                ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
              splashColor: Theme.of(context).splashColor,
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                BlocProvider.of<NavigationBloc>(context)
                    .add(NavigateToCoursesList());
                BlocProvider.of<CoursesBloc>(context)
                    .add(CourseDeleted(courseId));
              },
              child: Text('Yes'),
              splashColor: Theme.of(context).splashColor,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final courseId = ModalRoute.of(context).settings.arguments as String;
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, coursesState) {
        final course = (coursesState as CoursesLoadSuccess)
            .courses
            .firstWhere((course) => course.id == courseId);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '${course.name}',
              style: Theme.of(context).textTheme.headline5,
            ),
            leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
            actions: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => showDeleteDialog(context, course.id),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: [
                  Info(
                    course.id,
                    course.ic,
                    course.units,
                  ),
                  if (course.lecTime['days'].isNotEmpty)
                    ComponentDetail(
                      course.lecturer,
                      course.lecRoom,
                      course.lecSec,
                      course.lecTime,
                      ComponentType.Lecture,
                    ),
                  if (course.tutTime['days'].isNotEmpty)
                    ComponentDetail(
                      course.tutTeacher,
                      course.tutRoom,
                      course.tutSec,
                      course.tutTime,
                      ComponentType.Tutorial,
                    ),
                  if (course.labTime['days'].isNotEmpty)
                    ComponentDetail(
                      course.labTeacher,
                      course.labRoom,
                      course.labSec,
                      course.labTime,
                      ComponentType.Lab,
                    ),
                  Notes(courseId),
                  Marks(courseId),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
