import 'package:flutter/foundation.dart';

class Course {
  String name;
  String nick;
  String id;
  String ic;
  int units;
  String lecRoom;
  String tutRoom;
  String labRoom;
  String lecturer;
  String tutTeacher;
  String labTeacher;
  Map<dynamic, dynamic> lecTime;
  Map<dynamic, dynamic> tutTime;
  Map<dynamic, dynamic> labTime;
  String lecSec;
  String tutSec;
  String labSec;
  List<dynamic> notes;
  List<dynamic> marks;

  Course({
    @required this.name,
    @required this.nick,
    @required this.id,
    @required this.ic,
    @required this.units,
    @required this.lecRoom,
    @required this.tutRoom,
    @required this.labRoom,
    @required this.lecturer,
    @required this.tutTeacher,
    @required this.labTeacher,
    @required this.lecTime,
    @required this.tutTime,
    @required this.labTime,
    @required this.lecSec,
    @required this.tutSec,
    @required this.labSec,
    List<dynamic> notes,
    List<dynamic> marks,
  })  : this.notes = notes ?? <String>[],
        this.marks = marks ?? <Map<String, String>>[];

  Course copyWith({
    String name,
    String nick,
    String id,
    String ic,
    int units,
    String lecRoom,
    String tutRoom,
    String labRoom,
    String lecturer,
    String tutTeacher,
    String labTeacher,
    Map<String, List<dynamic>> lecTime,
    Map<String, List<dynamic>> tutTime,
    Map<String, List<dynamic>> labTime,
    String lecSec,
    String tutSec,
    String labSec,
    List<String> notes,
    List<Map<String, String>> marks,
  }) {
    return Course(
      name: name ?? this.name,
      nick: nick ?? this.nick,
      id: id ?? this.id,
      ic: ic ?? this.ic,
      units: units ?? this.units,
      lecRoom: lecRoom ?? this.lecRoom,
      tutRoom: tutRoom ?? this.tutRoom,
      labRoom: labRoom ?? this.labRoom,
      lecturer: lecturer ?? this.lecturer,
      tutTeacher: tutTeacher ?? this.tutTeacher,
      labTeacher: labTeacher ?? this.labTeacher,
      lecTime: lecTime ?? this.lecTime,
      tutTime: tutTime ?? this.tutTime,
      labTime: labTime ?? this.labTime,
      lecSec: labSec ?? this.lecSec,
      tutSec: tutSec ?? this.tutSec,
      labSec: labSec ?? this.labSec,
      notes: notes ?? this.notes,
      marks: marks ?? this.marks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'nick': this.nick,
      'id': this.id,
      'ic': this.ic,
      'units': this.units,
      'lecRoom': this.lecRoom,
      'tutRoom': this.tutRoom,
      'labRoom': this.labRoom,
      'lecturer': this.lecturer,
      'tutTeacher': this.tutTeacher,
      'labTeacher': this.labTeacher,
      'lecTime': this.lecTime,
      'tutTime': this.tutTime,
      'labTime': this.labTime,
      'lecSec': this.lecSec,
      'tutSec': this.tutSec,
      'labSec': this.labSec,
      'notes': this.notes,
      'marks': this.marks,
    };
  }
}
