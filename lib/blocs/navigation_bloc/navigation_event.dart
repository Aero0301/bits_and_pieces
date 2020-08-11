part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigateToLoginScreen extends NavigationEvent {}

class NavigateToCoursesList extends NavigationEvent {}

class NavigateToAddCourse extends NavigationEvent {}

class NavigateToCourseDetail extends NavigationEvent {
  final String courseId;
  const NavigateToCourseDetail(this.courseId);
}

class NavigateToExpenses extends NavigationEvent {}

class NavigateToExpensesInfo extends NavigationEvent {}


