import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList(this.transactions, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final transaction = transactions[index];

          return Card(
            elevation: 4,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '\$${transaction.amount.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              title: Text(
                transaction.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => transactions.remove(transaction),
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
