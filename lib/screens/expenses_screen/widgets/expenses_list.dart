import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/expenses_bloc/expenses_bloc.dart';
import '../../../models/expense.dart';
import './expenses_list_item.dart';
import './expenses_chart.dart';

class ExpensesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesBloc, ExpensesState>(
      builder: (context, expState) {
        var expensesList = (expState as ExpensesLoadSuccess).expenses;
        var expenses = {};
        expensesList..sort((e1, e2) => e2.id.compareTo(e1.id));
        expensesList.forEach((expense) {
          if (!(expenses.containsKey(expense.date))) {
            expenses[expense.date] = <Expense>[];
          }
          expenses[expense.date].add(expense);
        });
        return expensesList.isNotEmpty
            ? Column(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ExpensesChart(expensesList),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: PageView.builder(
                      itemBuilder: (context, index) {
                        var expIterable = expenses.keys;
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      expIterable.elementAt(index),
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                ...expenses[expIterable.elementAt(index)]
                                    .map((expense) {
                                  return ExpensesListItem(expense);
                                }).toList(),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: expenses.length,
                    ),
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Try Adding Some Expense!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              );
      },
    );
  }
}
