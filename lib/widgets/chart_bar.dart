import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double total;

  const ChartBar({
    Key? key,
    required this.label,
    required this.amount,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('\$${amount.toStringAsFixed(2)}'),
        const SizedBox(height: 4),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: const Color.fromARGB(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10)),
            ),
            FractionallySizedBox(
              heightFactor: total > 0 ? amount / total : 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ]),
        ),
        const SizedBox(height: 4),
        Text(label)
      ],
    );
  }
}
