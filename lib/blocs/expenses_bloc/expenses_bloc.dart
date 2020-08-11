import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/expenses_repository.dart';
import '../../models/expense.dart';

part 'expenses_event.dart';
part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  ExpensesRepository _expensesRepository;
  DocumentReference _documentReference;

  ExpensesBloc() : super(ExpensesInitial());

  @override
  Stream<ExpensesState> mapEventToState(
    ExpensesEvent event,
  ) async* {
    try {
      if (event is ExpensesLoadStarted) {
        _documentReference = event.documentReference;
        _expensesRepository = ExpensesRepository(_documentReference);
        var expenses = await _expensesRepository.getExpenses();
        yield ExpensesLoadSuccess(expenses);
      } else if (event is AddExpense) {
        await _expensesRepository.addExpense(event.expense);
        var expenses = await _expensesRepository.getExpenses();
        yield ExpensesLoadSuccess(expenses);
      } else if (event is DeleteExpense) {
        await _expensesRepository.deleteExpense(event.id);
        var expenses = await _expensesRepository.getExpenses();
        yield ExpensesLoadSuccess(expenses);
      } else if (event is DeleteAllExpenses) {
        await _expensesRepository.deleteAllExpenses();
        var expenses = await _expensesRepository.getExpenses();
        yield ExpensesLoadSuccess(expenses);
      }
    } catch (e) {
      yield ExpensesLoadFailed();
    }
  }
}
