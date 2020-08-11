part of 'courses_bloc.dart';

abstract class CoursesState extends Equatable {
  const CoursesState();
  @override
  List<Object> get props => [];
}

class Uninitialized extends CoursesState {}

class CoursesLoadSuccess extends CoursesState {
  final List<Course> courses;

  const CoursesLoadSuccess(this.courses);

  @override
  List<Object> get props => courses;
}

class CoursesLoadFailed extends CoursesState {}
