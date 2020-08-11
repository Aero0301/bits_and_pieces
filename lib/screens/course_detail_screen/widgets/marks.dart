import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/courses_bloc/courses_bloc.dart';

class Marks extends StatelessWidget {
  final String courseId;

  Marks(this.courseId);

  void showPopupMenu(BuildContext context, dynamic comp) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ListTile(
          leading: Icon(
            Icons.delete,
            color: Colors.black,
          ),
          title: Text(
            'Delete Marks',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.black,
                ),
          ),
          onTap: () {
            Navigator.of(context).pop();
            BlocProvider.of<CoursesBloc>(context)
                .add(MarksDeleted(courseId, comp));
          },
        );
      },
    );
  }

  void addMarks(BuildContext context) {
    Scaffold.of(context).hideCurrentSnackBar();
    var compController = TextEditingController();
    var marksController = TextEditingController();
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
                  controller: compController,
                  minLines: 1,
                  maxLines: 50,
                  decoration: const InputDecoration(labelText: 'Component'),
                  keyboardType: TextInputType.multiline,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.black,
                      ),
                ),
                TextField(
                  controller: marksController,
                  decoration: const InputDecoration(labelText: 'Marks'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                        'Add Marks',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onPressed: () {
                        BlocProvider.of<CoursesBloc>(context).add(MarksAdded(
                          courseId,
                          {
                            'comp': compController.text,
                            'marks': marksController.text
                          },
                        ));
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
        var marksList = (state as CoursesLoadSuccess)
            .courses
            .firstWhere((course) => course.id == courseId)
            .marks;

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
                          'Marks',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Colors.black,
                              ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(0.9, 0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: () => addMarks(context),
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
                ...marksList.asMap().entries.map((mark) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Divider(),
                      InkWell(
                        onTap: () => showPopupMenu(context, mark.value['comp']),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Text(
                                  mark.value['comp'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                                fit: FlexFit.tight,
                              ),
                              Text(
                                mark.value['marks'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                            ],
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
