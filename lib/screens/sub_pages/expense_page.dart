import 'package:easy_tracker/utils/entry_manager.dart';
import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/widgets/entry_card.dart';
import 'package:flutter/material.dart';

class ExpensePage extends StatefulWidget {
  final EntryManager data;

  const ExpensePage({
    Key? key,
    required this.data
  }): super(key: key);

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  Widget build(BuildContext context) {
    int index = 0;
    List<Widget> wdgList = [];
    for (var entry in widget.data.expList) {
      wdgList.add(const SizedBox(height: 10));
      wdgList.add(
        EntryCard(
          id: index++,
          name: entry.name!,
          amount: -(entry.amount),
          timestamp: entry.timestamp,
          description: entry.description!
        )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expenses",
          style: bodyMedium,
        ),
        backgroundColor: fgWhite,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          color: Colors.black,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            if (wdgList.isEmpty)
              const Text(
                "No Expense Entry!\nTry adding some",
                style: bodySmall,
              ),
            if (wdgList.isNotEmpty)
              Column(
                children: wdgList,
              ),
          ],
        )
      )
    );
  }
}