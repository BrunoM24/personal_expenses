import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final void Function(String title, double amount) onSubmit;

  const NewTransaction({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submit() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0) return;

    widget.onSubmit(title, amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
              autofocus: true,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              onSubmitted: (_) => submit(),
            ),
            Row(
              children: [
                const Text('No Date Chosen!'),
                TextButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050),
                      );
                    },
                    child: const Text('Choose Date')),
              ],
            ),
            MaterialButton(
              onPressed: submit,
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
