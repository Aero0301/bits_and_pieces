import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../../models/expense.dart';

class ExpensesChart extends StatelessWidget {
  final List<Bar> totalList = <Bar>[];
  final List<Expense> expList;

  ExpensesChart(this.expList);

  @override
  Widget build(BuildContext context) {
    expList.forEach((exp) {
      var index = totalList.indexWhere((bar) => bar.place == exp.place);
      if (index == -1) {
        totalList.add(Bar(exp.place, exp.amount));
      } else {
        totalList[index].amount += exp.amount;
      }
    });
    var seriesList = <charts.Series<Bar, String>>[
      charts.Series<Bar, String>(
        data: totalList,
        id: 'Expenses',
        colorFn: (_, __) => charts.Color(r: 255, g: 170, b: 0),
        domainFn: (Bar bar, _) => bar.place,
        measureFn: (Bar bar, _) => bar.amount,
      ),
    ];
    return charts.BarChart(
      seriesList,
      animate: true,
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontFamily: 'Futura',
            fontSize: 10,
            color: charts.MaterialPalette.white,
          ),
        ),
      ),
      domainAxis: charts.AxisSpec<String>(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontFamily: 'Futura',
            fontSize: 14,
            color: charts.MaterialPalette.white,
          ),
        ),
      ),
    );
  }
}

class Bar {
  int amount;
  String place;
  Bar(this.place, this.amount);
}
