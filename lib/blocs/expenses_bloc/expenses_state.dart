part of 'expenses_bloc.dart';

abstract class ExpensesState extends Equatable {
  const ExpensesState();
  @override
  List<Object> get props => [];
}

class ExpensesInitial extends ExpensesState {}

class ExpensesLoadSuccess extends ExpensesState {
  final List<Expense> expenses;
  ExpensesLoadSuccess(this.expenses);

  @override
  List<Object> get props => expenses;
}

class ExpensesLoadFailed extends ExpensesState {}
