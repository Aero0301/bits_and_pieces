import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Expense extends Equatable {
  final String date;
  final String place;
  final String description;
  final int amount;
  final DateTime id;

  Expense({
    @required this.date,
    @required this.place,
    @required this.description,
    @required this.amount,
    @required this.id,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toMap() {
    return {
      'date': this.date,
      'place': this.place,
      'description': this.description,
      'amount': this.amount,
      'id': this.id.toString(),
    };
  }

  Expense copyWith({int amount}) {
    return Expense(
      date: this.date,
      place: this.place,
      description: this.description,
      amount: amount ?? this.amount,
      id: this.id,
    );
  }
}
