import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/courses_bloc/courses_bloc.dart';

class Notes extends StatelessWidget {
  final String courseId;

  Notes(this.courseId);

  void showPopupMenu(BuildContext context, MapEntry<int, dynamic> note) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
                title: Text(
                  'Edit Note',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.black,
                      ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  editNote(context, note.key);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
                title: Text(
                  'Delete Note',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.black,
                      ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  BlocProvider.of<CoursesBloc>(context)
                      .add(NoteDeleted(courseId, note.value));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void addNote(BuildContext context) {
    var addController = TextEditingController();
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 10.0,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                TextField(
                  controller: addController,
                  minLines: 1,
                  maxLines: 50,
                  decoration: const InputDecoration(labelText: 'Note'),
                  keyboardType: TextInputType.multiline,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.black,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      textColor: Colors.white,
                      child: Text(
                        'Add Note',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onPressed: () {
                        BlocProvider.of<CoursesBloc>(context)
                            .add(NoteAdded(courseId, addController.text));
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void editNote(BuildContext context, int noteIndex) {
    var notesList =
        (BlocProvider.of<CoursesBloc>(context).state as CoursesLoadSuccess)
            .courses
            .firstWhere((course) => course.id == courseId)
            .notes;
    var editController = TextEditingController(text: notesList[noteIndex]);
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 10.0,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                TextField(
                  controller: editController,
                  minLines: 1,
                  maxLines: 50,
                  decoration: const InputDecoration(labelText: 'Note'),
                  keyboardType: TextInputType.multiline,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.black,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      textColor: Colors.white,
                      child: Text(
                        'Edit Note',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onPressed: () {
                        notesList[noteIndex] = editController.text;
                        BlocProvider.of<CoursesBloc>(context)
                            .add(NoteEdited(courseId, notesList));
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        var notesList = (state as CoursesLoadSuccess)
            .courses
            .firstWhere((course) => course.id == courseId)
            .notes;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Notes',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Colors.black,
                              ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(0.9, 0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: () => addNote(context),
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ...notesList.asMap().entries.map((note) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Divider(),
                      InkWell(
                        onTap: () => showPopupMenu(context, note),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            note.value,
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
