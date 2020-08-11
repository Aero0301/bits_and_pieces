import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/navigation_bloc/navigation_bloc.dart';
import '../../../blocs/courses_bloc/courses_bloc.dart';

class CourseListItem extends StatelessWidget {
  final String courseId;

  CourseListItem(this.courseId);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(builder: (context, state) {
      var course = (state as CoursesLoadSuccess)
          .courses
          .firstWhere((course) => course.id == courseId);
      return Hero(
        tag: courseId,
        child: Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            splashColor: Theme.of(context).accentColor,
            onTap: () {
              BlocProvider.of<NavigationBloc>(context).add(NavigateToCourseDetail(courseId));
            },
            child: ListTile(
              title: Text(
                course.name,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.black,
                    ),
              ),
              subtitle: Text(
                'Units: ${course.units} | IC: ${course.ic}',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
