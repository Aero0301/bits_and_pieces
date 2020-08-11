import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../screens/courses_screen/courses_screen.dart';
import '../../screens/add_course_screen/add_course_screen.dart';
import '../../screens/course_detail_screen/course_detail_screen.dart';
import '../../screens/login_screen/login_screen.dart';
import '../../screens/expenses_screen/expenses_screen.dart';
import '../../screens/expenses_info_screen/expenses_info_screen.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationBloc(this.navigatorKey)
      : super(NavigationDefault(Section.LoginScreen));

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event is NavigateToLoginScreen) {
      navigatorKey.currentState.pushReplacementNamed(LoginScreen.routeName);
      yield NavigationDefault(Section.LoginScreen);
    } else if (event is NavigateToCoursesList) {
      navigatorKey.currentState.pushReplacementNamed(CoursesScreen.routeName);
      yield NavigationDefault(Section.CoursesScreen);
    } else if (event is NavigateToAddCourse) {
      navigatorKey.currentState.pushNamed(AddCourseScreen.routeName);
    } else if (event is NavigateToCourseDetail) {
      navigatorKey.currentState.pushNamed(
        CourseDetailScreen.routeName,
        arguments: event.courseId,
      );
    } else if (event is NavigateToExpenses) {
      navigatorKey.currentState.pushReplacementNamed(ExpensesScreen.routeName);
      yield NavigationDefault(Section.ExpensesScreen);
    } else if (event is NavigateToExpensesInfo) {
      navigatorKey.currentState.pushNamed(ExpensesInfoScreen.routeName);
    }
  }
}
