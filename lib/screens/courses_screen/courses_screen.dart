import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/courses_bloc/courses_bloc.dart';
import '../../blocs/navigation_bloc/navigation_bloc.dart';
import './widgets/courses_list.dart';
import '../../blocs/authenthicaton_bloc/authentication_bloc.dart';
import './widgets/time_table.dart';
import '../../widgets/drawer.dart';

class CoursesScreen extends StatelessWidget {
  static const routeName = '/courses_screen';

  void _showTableDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => TimeTable(),
    ).then((_) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
        if (authState is Authenticated) {
          BlocProvider.of<CoursesBloc>(context).add(CoursesLoadStarted(
            authState.documentReference,
          ));
        }
        return BlocBuilder<CoursesBloc, CoursesState>(
          builder: (context, coursesState) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Courses',
                  style: Theme.of(context).textTheme.headline5,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => BlocProvider.of<NavigationBloc>(context)
                        .add(NavigateToAddCourse()),
                  ),
                ],
              ),
              drawer: SideDrawer(),
              body: coursesState is CoursesLoadSuccess
                  ? CoursesList()
                  : (coursesState is CoursesLoadFailed
                      ? Center(
                          child: Text(
                            'Error Loading Courses!',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        )
                      : LinearProgressIndicator()),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: coursesState is CoursesLoadSuccess
                  ? FloatingActionButton(
                      onPressed: () => _showTableDialog(context),
                      child: Icon(
                        Icons.view_comfy,
                        color: Colors.black,
                      ),
                    )
                  : null,
            );
          },
        );
      },
    );
  }
}
