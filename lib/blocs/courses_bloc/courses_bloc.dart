import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../models/course.dart';
import '../../repositories/courses_repository.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesRepository _coursesRepository;
  DocumentReference _documentReference;

  CoursesBloc() : super(Uninitialized());

  @override
  Stream<CoursesState> mapEventToState(
    CoursesEvent event,
  ) async* {
    try {
      if (event is CoursesLoadStarted) {
        _documentReference = event.documentReference;
        _coursesRepository = CoursesRepository(_documentReference);
        yield* _mapLoadStartedToState();
      }

      if (event is CourseAdded) {
        yield* _mapCourseAddedToState(event);
      }

      if (event is CourseDeleted) {
        yield* _mapCourseDeletedToState(event);
      }

      if (event is CourseEdited) {
        yield* _mapCourseEditedToState(event);
      }

      if (event is NoteAdded) {
        yield* _mapNoteAddedToState(event);
      }

      if (event is NoteDeleted) {
        yield* _mapNoteDeletedToState(event);
      }

      if (event is NoteEdited) {
        yield* _mapNoteEditedToState(event);
      }

      if (event is MarksAdded) {
        yield* _mapMarksAddedToState(event);
      }
      if (event is MarksDeleted) {
        yield* _mapMarksDeletedToState(event);
      }
    } catch (e) {
      yield CoursesLoadFailed();
    }
  }

  Stream<CoursesState> _mapLoadStartedToState() async* {
    var courses = await _coursesRepository.getCourses();

    yield CoursesLoadSuccess(courses);
  }

  Stream<CoursesState> _mapCourseAddedToState(CoursesEvent event) async* {
    await _coursesRepository.addCourse((event as CourseAdded).course);
    var courses = await _coursesRepository.getCourses();
    yield CoursesLoadSuccess(courses);
  }

  Stream<CoursesState> _mapCourseDeletedToState(CoursesEvent event) async* {
    await _coursesRepository.deleteCourse((event as CourseDeleted).id);
    var courses = await _coursesRepository.getCourses();
    yield CoursesLoadSuccess(courses);
  }

  Stream<CoursesState> _mapCourseEditedToState(CoursesEvent event) async* {
    await _coursesRepository.editCourse((event as CourseEdited).course);
    var courses = await _coursesRepository.getCourses();
    yield CoursesLoadSuccess(courses);
  }

  Stream<CoursesState> _mapNoteAddedToState(CoursesEvent event) async* {
    await _coursesRepository.addNote(
        (event as NoteAdded).id, (event as NoteAdded).note);
    var courses = await _coursesRepository.getCourses();
    yield CoursesLoadSuccess(courses);
  }

  Stream<CoursesState> _mapNoteDeletedToState(CoursesEvent event) async* {
    await _coursesRepository.deleteNote(
        (event as NoteDeleted).id, (event as NoteDeleted).note);
    var courses = await _coursesRepository.getCourses();
    yield CoursesLoadSuccess(courses);
  }

  Stream<CoursesState> _mapNoteEditedToState(CoursesEvent event) async* {
    await _coursesRepository.editNote(
        (event as NoteEdited).id, (event as NoteEdited).notes);
    var courses = await _coursesRepository.getCourses();
    yield CoursesLoadSuccess(courses);
  }

  Stream<CoursesState> _mapMarksAddedToState(CoursesEvent event) async* {
    await _coursesRepository.addMarks(
        (event as MarksAdded).id, (event as MarksAdded).mark);
    var courses = await _coursesRepository.getCourses();
    yield CoursesLoadSuccess(courses);
  }

  Stream<CoursesState> _mapMarksDeletedToState(CoursesEvent event) async* {
    await _coursesRepository.deleteMarks(
        (event as MarksDeleted).id, (event as MarksDeleted).comp);
    var courses = await _coursesRepository.getCourses();
    yield CoursesLoadSuccess(courses);
  }
}
