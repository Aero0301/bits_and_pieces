import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/courses_bloc/courses_bloc.dart';

class TimeTable extends StatelessWidget {
  static const routeName = '/tt';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, coursesState) {
        final courses = (coursesState as CoursesLoadSuccess).courses;

        List<int> times = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        List<String> days = ['M', 'T', 'W', 'Th', 'F', 'S'];

        List<List<DataCell>> tt = [];

        for (int i = 0; i < 6; i++) {
          List<DataCell> temp = [
            DataCell(
              Text(
                '${days[i]}',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Colors.black,
                    ),
              ),
            )
          ];
          for (int j = 0; j < 10; j++) {
            var lec = courses.firstWhere(
              (course) {
                return course.lecTime['days'].contains(indexToDay(i)) &&
                    course.lecTime['time'].contains(j + 1);
              },
              orElse: () => null,
            );
            var tut = courses.firstWhere(
              (course) {
                return course.tutTime['days'].contains(indexToDay(i)) &&
                    course.tutTime['time'].contains(j + 1);
              },
              orElse: () => null,
            );
            var lab = courses.firstWhere(
              (course) {
                return course.labTime['days'].contains(indexToDay(i)) &&
                    course.labTime['time'].contains(j + 1);
              },
              orElse: () => null,
            );
            temp.add(DataCell(
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    lec != null
                        ? lec.nick
                        : (tut != null
                            ? tut.nick
                            : (lab != null ? lab.nick : '')),
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  Text(
                    lec != null
                        ? '${lec.lecRoom} - L'
                        : (tut != null
                            ? '${tut.tutRoom} - T'
                            : (lab != null ? '${lab.labRoom} - P' : '')),
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
            ));
          }
          tt.add(temp);
        }
        return SimpleDialog(
          titlePadding: const EdgeInsets.only(top: 10),
          contentPadding: const EdgeInsets.all(10),
          title: Text(
            'Time Table',
            style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.black,
                ),
            textAlign: TextAlign.center,
          ),
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20.0,
                dataRowHeight: 36.0,
                headingRowHeight: 36.0,
                columns: times.map((time) {
                  return DataColumn(
                    label: Column(
                      children: <Widget>[
                        Text(
                          time != 0 ? '$time' : '',
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          '${time != 0 ? realTime(time) : ''}',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.fade,
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Colors.black,
                              ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                rows: List<DataRow>.generate(6, (index) {
                  return DataRow(cells: tt[index]);
                }),
              ),
            )
          ],
        );
      },
    );
  }
}

String realTime(int slot) {
  return slot <= 4 ? '${slot + 7}:00 am' : '${slot == 5 ? 12 : slot - 5}:00 pm';
}

String indexToDay(int index) {
  switch (index) {
    case 0:
      return 'M';
    case 1:
      return 'T';
    case 2:
      return 'W';
    case 3:
      return 'Th';
    case 4:
      return 'F';
    case 5:
      return 'S';
    default:
      return 'M';
  }
}
