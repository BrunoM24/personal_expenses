import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentTransactions, {Key? key}) : super(key: key);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));

        double sum = 0;

        for (var transaction in recentTransactions) {
          if (transaction.date.day == weekDay.day) {
            sum += transaction.amount;
          }
        }

        return {
          'day': DateFormat.E().format(weekDay),
          'amount': sum,
        };
      },
    );
  }

  double get maxSpending {
    return groupedTransactionValues.fold(
        0,
        (previousValue, element) =>
            previousValue + (element['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: groupedTransactionValues.reversed
            .map(
              (e) => ChartBar(
                label: e['day'] as String,
                amount: e['amount'] as double,
                total: maxSpending,
              ),
            )
            .toList(),
      ),
    );
  }
}
