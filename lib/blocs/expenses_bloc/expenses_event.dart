part of 'expenses_bloc.dart';

abstract class ExpensesEvent extends Equatable {
  const ExpensesEvent();

  @override
  List<Object> get props => [];
}

class ExpensesLoadStarted extends ExpensesEvent {
  final DocumentReference documentReference;

  ExpensesLoadStarted(this.documentReference);
}

class AddExpense extends ExpensesEvent {
  final Expense expense;

  AddExpense(this.expense);
}

class DeleteExpense extends ExpensesEvent {
  final String id;

  DeleteExpense(this.id);
}

class DeleteAllExpenses extends ExpensesEvent {}
