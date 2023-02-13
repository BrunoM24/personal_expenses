import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction>? get _recentTransactions {
    return _transactions
        .where(
          (t) => t.date.isAfter(
            DateTime.now().subtract(
              const Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  void _openModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => NewTransaction(
        onSubmit: (title, amount) => setState(() {
          _transactions.add(
            Transaction(
              id: DateTime.now().toString(),
              title: title,
              amount: amount,
              date: DateTime.now(),
            ),
          );

          Navigator.pop(context);
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
        actions: [
          IconButton(
            onPressed: () => _openModal(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(child: Chart(_recentTransactions!)),
          _transactions.isEmpty
              ? Center(child: Image.asset('assets/waiting.png'))
              : TransactionList(_transactions),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
