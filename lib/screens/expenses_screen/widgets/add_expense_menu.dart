import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/expense.dart';
import '../../../blocs/expenses_bloc/expenses_bloc.dart';

enum PlacesOptions {
  Akshay,
  ANC,
  CNot,
  IC,
  Mess,
  Looters,
  Redi,
  Signing,
  Skylabs,
  TOTT,
  Others,
}

class AddExpenseMenu extends StatefulWidget {
  @override
  _AddExpenseMenuState createState() => _AddExpenseMenuState();
}

class _AddExpenseMenuState extends State<AddExpenseMenu> {
  PlacesOptions place;

  final descController = TextEditingController();
  final amtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    place = PlacesOptions.Others;
  }

  void addExpense(Expense exp) {
    BlocProvider.of<ExpensesBloc>(context).add(AddExpense(exp));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
              controller: descController,
              maxLength: 100,
              decoration: const InputDecoration(labelText: 'Description'),
              keyboardType: TextInputType.text,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.black,
                  ),
            ),
            TextField(
              controller: amtController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.black,
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<PlacesOptions>(
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.black,
                      ),
                  value: place,
                  elevation: 30,
                  items: [
                    DropdownMenuItem(
                      child: Text(placesToString(PlacesOptions.Akshay)),
                      value: PlacesOptions.Akshay,
                    ),
                    DropdownMenuItem(
                      child: Text(placesToString(PlacesOptions.ANC)),
                      value: PlacesOptions.ANC,
                    ),
                    DropdownMenuItem(
                      child: Text(placesToString(PlacesOptions.CNot)),
                      value: PlacesOptions.CNot,
                    ),
                    DropdownMenuItem(
                      child: Text(placesToString(PlacesOptions.IC)),
                      value: PlacesOptions.IC,
                    ),
                    DropdownMenuItem(
                      child: Text(placesToString(PlacesOptions.Mess)),
                      value: PlacesOptions.Mess,
                    ),
                    DropdownMenuItem(
                      child: Text(placesToString(PlacesOptions.Looters)),
                      value: PlacesOptions.Looters,
                    ),
                    DropdownMenuItem(
                      child: Text(placesToString(PlacesOptions.Redi)),
                      value: PlacesOptions.Redi,
                    ),
                    DropdownMenuItem(
                      child: Text(placesToString(PlacesOptions.Signing)),
                      value: PlacesOptions.Signing,
                    ),
                    DropdownMenuItem(
                      child: Text(placesToString(PlacesOptions.Skylabs)),
                      value: PlacesOptions.Skylabs,
                    ),
                    DropdownMenuItem(
                      child: Text(placesToString(PlacesOptions.TOTT)),
                      value: PlacesOptions.TOTT,
                    ),
                    DropdownMenuItem(
                      child: Text(placesToString(PlacesOptions.Others)),
                      value: PlacesOptions.Others,
                    ),
                  ],
                  onChanged: (option) {
                    setState(() {
                      place = option;
                    });
                    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                  },
                ),
                RaisedButton(
                  textColor: Colors.white,
                  child: Text(
                    'Add',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onPressed: () {
                    var expense = Expense(
                      date: DateFormat.yMMMMd().format(DateTime.now()),
                      place: placesToString(place),
                      description: descController.text,
                      amount: int.parse(amtController.text),
                      id: DateTime.now(),
                    );
                    addExpense(expense);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String placesToString(PlacesOptions option) {
    switch (option) {
      case PlacesOptions.ANC:
        return 'ANC';
      case PlacesOptions.Akshay:
        return 'Akshay';
      case PlacesOptions.CNot:
        return "C'Not";
      case PlacesOptions.IC:
        return 'IC';
      case PlacesOptions.Looters:
        return 'Looters';
      case PlacesOptions.Mess:
        return 'Mess';
      case PlacesOptions.Others:
        return 'Others';
      case PlacesOptions.Redi:
        return 'Redi';
      case PlacesOptions.Skylabs:
        return 'Skylabs';
      case PlacesOptions.TOTT:
        return 'TOTT';
      case PlacesOptions.Signing:
        return 'Signing';
      default:
        return 'Others';
    }
  }
}
