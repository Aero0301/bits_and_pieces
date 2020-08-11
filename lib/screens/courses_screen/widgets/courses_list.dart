import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/courses_bloc/courses_bloc.dart';
import './courses_list_item.dart';

class CoursesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        if (state is CoursesLoadSuccess) {
          var courseList =
              state.courses.map((course) => CourseListItem(course.id)).toList();
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: courseList.isNotEmpty
                    ? Column(children: courseList,)
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Try Adding Some Courses!',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ],
                    ),
            ),
          );
        } else if (state is CoursesLoadStarted) {
          return LinearProgressIndicator();
        } else if (state is CoursesLoadFailed) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                duration: Duration(seconds: 2),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Network Error',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    Icon(
                      Icons.error,
                      color: Theme.of(context).errorColor,
                    )
                  ],
                ),
              ),
            );
          return Container();
        } else {
          return Container();
        }
      },
    );
  }
}
