part of 'courses_bloc.dart';

abstract class CoursesEvent extends Equatable {
  const CoursesEvent();

  @override
  List<Object> get props => [];
}

class CoursesLoadStarted extends CoursesEvent {
  final DocumentReference documentReference;
  const CoursesLoadStarted(this.documentReference);
}

class CourseAdded extends CoursesEvent {
  final Course course;
  const CourseAdded(this.course);
}

class CourseDeleted extends CoursesEvent {
  final String id;
  const CourseDeleted(this.id);
}

class CourseEdited extends CoursesEvent {
  final Course course;
  const CourseEdited(this.course);
}

class NoteAdded extends CoursesEvent {
  final String id;
  final String note;

  const NoteAdded(this.id, this.note);
}

class NoteDeleted extends CoursesEvent {
  final String id;
  final String note;

  const NoteDeleted(this.id, this.note);
}

class NoteEdited extends CoursesEvent {
  final String id;
  final List<dynamic> notes;

  const NoteEdited(this.id, this.notes);
}

class MarksAdded extends CoursesEvent {
  final String id;
  final dynamic mark;

  const MarksAdded(this.id, this.mark);
}

class MarksDeleted extends CoursesEvent {
  final String id;
  final String comp;

  const MarksDeleted(this.id, this.comp);
}