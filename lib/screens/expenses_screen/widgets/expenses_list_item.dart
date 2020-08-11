import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/expense.dart';
import '../../../blocs/expenses_bloc/expenses_bloc.dart';

class ExpensesListItem extends StatelessWidget {
  final Expense expense;

  ExpensesListItem(this.expense);

  void showPopupMenu(BuildContext context, String expId) {
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
            'Delete Entry',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.black,
                ),
          ),
          onTap: () {
            Navigator.of(context).pop();
            BlocProvider.of<ExpensesBloc>(context).add(DeleteExpense(expId));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              style: BorderStyle.solid,
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            '${NumberFormat().simpleCurrencySymbol('INR')}${expense.amount}',
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.black,
                ),
          ),
        ),
        title: Text(
          expense.place,
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.black,
              ),
          textAlign: TextAlign.start,
        ),
        subtitle: Text(
          expense.description,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Colors.black,
              ),
          textAlign: TextAlign.start,
        ),
        trailing: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () => showPopupMenu(context, expense.id.toString()),
          child: Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
