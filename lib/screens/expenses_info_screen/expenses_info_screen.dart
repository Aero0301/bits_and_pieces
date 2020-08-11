import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/expenses_bloc/expenses_bloc.dart';

class ExpensesInfoScreen extends StatelessWidget {
  static const routeName = '/expenses_info_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesBloc, ExpensesState>(
      builder: (context, expState) {
        var expList = (expState as ExpensesLoadSuccess).expenses;
        Map<String, Map<String, int>> expMap = {};
        expList.forEach((element) {
          var date = DateFormat.yMMMM().format(element.id).toString();
          if (expMap[date] == null) {
            expMap[date] = {};
          }
          if (expMap[date]['Total'] == null) {
            expMap[date]['Total'] = 0;
          }
          expMap[date]['Total'] += element.amount;
          if (expMap[date][element.place] == null) {
            expMap[date][element.place] = 0;
          }
          expMap[date][element.place] += element.amount;
        });
        var iterable = expMap.keys;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'Statistics',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: iterable.map((e) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            e,
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          Divider(),
                          ...expMap[e].keys.map((type) {
                            if (type != 'Total' && type != 'Others')
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      type,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                            color: Colors.black,
                                          ),
                                    ),
                                    Text(
                                      '${NumberFormat().simpleCurrencySymbol('INR')}${expMap[e][type]}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                            color: Colors.black,
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            else
                              return Container();
                          }).toList(),
                          if (expMap[e]['Others'] != null)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Others',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                  Text(
                                    '${NumberFormat().simpleCurrencySymbol('INR')}${expMap[e]['Others']}',
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
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Total',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                                Text(
                                  '${NumberFormat().simpleCurrencySymbol('INR')}${expMap[e]['Total']}',
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
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
