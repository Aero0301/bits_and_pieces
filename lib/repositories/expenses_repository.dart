import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/expense.dart';

class ExpensesRepository {
  final DocumentReference _documentReference;

  ExpensesRepository(this._documentReference);

  Future<List<Expense>> getExpenses() async {
    var expensesSnapshots =
        (await _documentReference.collection('expenses').getDocuments())
            .documents;
    var expenses = expensesSnapshots.map((snap) {
      var data = snap.data;
      var expense = Expense(
        date: data['date'],
        place: data['place'],
        description: data['description'],
        amount: data['amount'],
        id: DateTime.parse(data['id']),
      );
      return expense;
    }).toList();
    print(expenses);
    return expenses;
  }

  Future<void> addExpense(Expense expense) async {
    _documentReference
        .collection('expenses')
        .document(expense.id.toString())
        .setData(expense.toMap());
  }

  Future<void> deleteExpense(String id) async {
    _documentReference.collection('expenses').document(id).delete();
  }

  Future<void> deleteAllExpenses() async {
    var expenses = await getExpenses();
    expenses.forEach((expense) async {
      await deleteExpense(expense.id.toString());
    });
  }
}
