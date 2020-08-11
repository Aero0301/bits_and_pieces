import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/drawer.dart';
import '../../blocs/authenthicaton_bloc/authentication_bloc.dart';
import '../../blocs/expenses_bloc/expenses_bloc.dart';
import '../../blocs/navigation_bloc/navigation_bloc.dart';
import './widgets/expenses_list.dart';
import './widgets/add_expense_menu.dart';

class ExpensesScreen extends StatelessWidget {
  static const routeName = '/expenses_screen';

  void showAddExpense(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return AddExpenseMenu();
      },
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Delete All',
            style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.black,
                ),
          ),
          content: Text(
            'Are you sure you want to delete all entries?',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.black,
                ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
              splashColor: Theme.of(context).splashColor,
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                BlocProvider.of<ExpensesBloc>(context).add(DeleteAllExpenses());
              },
              child: Text('Yes'),
              splashColor: Theme.of(context).splashColor,
            ),
          ],
        );
      },
    ).then((_) {
      BlocProvider.of<ExpensesBloc>(context).add(ExpensesLoadStarted(
          (BlocProvider.of<AuthenticationBloc>(context).state as Authenticated)
              .documentReference));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
        if (authState is Authenticated) {
          BlocProvider.of<ExpensesBloc>(context)
              .add(ExpensesLoadStarted(authState.documentReference));
        }
        return BlocBuilder<ExpensesBloc, ExpensesState>(
          builder: (context, expState) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Expense Tracker',
                  style: Theme.of(context).textTheme.headline5,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () => BlocProvider.of<NavigationBloc>(context)
                        .add(NavigateToExpensesInfo()),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showDeleteDialog(context);
                    },
                  ),
                ],
              ),
              drawer: SideDrawer(),
              body: expState is ExpensesLoadSuccess
                  ? ExpensesList()
                  : (expState is ExpensesLoadFailed
                      ? Center(
                          child: Text(
                            'Error Loading Expenses!',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        )
                      : LinearProgressIndicator()),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: expState is ExpensesLoadSuccess
                  ? FloatingActionButton(
                      onPressed: () => showAddExpense(context),
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    )
                  : null,
            );
          },
        );
      },
    );
  }
}
