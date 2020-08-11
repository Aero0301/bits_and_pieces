import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/course.dart';

class CoursesRepository {
  final DocumentReference _documentReference;

  CoursesRepository(this._documentReference);

  Future<List<Course>> getCourses() async {
    var coursesSnapshots =
        (await _documentReference.collection('courses').getDocuments())
            .documents;
    var courses = coursesSnapshots.map((snap) {
      var data = snap.data;
      var course = Course(
        name: data['name'] ?? '',
        nick: data['nick'] ?? '',
        id: data['id'] ?? '',
        ic: data['ic'] ?? '',
        units: data['units'] ?? 0,
        lecRoom: data['lecRoom'] ?? '',
        tutRoom: data['tutRoom'] ?? '',
        labRoom: data['labRoom'] ?? '',
        lecturer: data['lecturer'] ?? '',
        tutTeacher: data['tutTeacher'] ?? '',
        labTeacher: data['labTeacher'] ?? '',
        lecTime: data['lecTime'] ?? {'days': <String>[], 'time': <int>[]},
        tutTime: data['tutTime'] ?? {'days': <String>[], 'time': <int>[]},
        labTime: data['labTime'] ?? {'days': <String>[], 'time': <int>[]},
        lecSec: data['lecSec'] ?? '',
        tutSec: data['tutSec'] ?? '',
        labSec: data['labSec'] ?? '',
        notes: ((data['notes'] as List).isEmpty ? <String>[] : data['notes']) ??
            <String>[],
        marks: (data['marks'] as List).isEmpty
            ? <dynamic>[]
            : data['marks'] ?? <Map<String, String>>[],
      );
      return course;
    }).toList();
    return courses;
  }

  Future<void> addCourse(Course course) async {
    _documentReference
        .collection('courses')
        .document(course.id)
        .setData(course.toMap());
  }

  Future<void> deleteCourse(String id) async {
    _documentReference.collection('courses').document(id).delete();
  }

  Future<void> editCourse(Course course) async {
    _documentReference
        .collection('courses')
        .document(course.id)
        .setData(course.toMap(), merge: true);
  }

  Future<void> addNote(String id, String note) async {
    var notes =
        (await _documentReference.collection('courses').document(id).get())
            .data['notes'];
    (notes as List).add(note);
    _documentReference
        .collection('courses')
        .document(id)
        .updateData({'notes': notes});
  }

  Future<void> deleteNote(String id, String note) async {
    var notes =
        (await _documentReference.collection('courses').document(id).get())
            .data['notes'];
    (notes as List).remove(note);
    _documentReference
        .collection('courses')
        .document(id)
        .updateData({'notes': notes});
  }

  Future<void> editNote(String id, List<dynamic> notes) async {
    _documentReference
        .collection('courses')
        .document(id)
        .updateData({'notes': notes});
  }

  Future<void> addMarks(String id, dynamic mark) async {
    var marks =
        (await _documentReference.collection('courses').document(id).get())
            .data['marks'];
    (marks as List).add(mark);
    _documentReference
        .collection('courses')
        .document(id)
        .updateData({'marks': marks});
  }

  Future<void> deleteMarks(String id, String comp) async {
    var marks =
        (await _documentReference.collection('courses').document(id).get())
            .data['marks'];
    (marks as List).removeWhere((mark) => mark['comp'] == comp);
    _documentReference
        .collection('courses')
        .document(id)
        .updateData({'marks': marks});
  }
}