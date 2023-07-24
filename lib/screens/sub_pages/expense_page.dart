// 3rd-party Packages
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Local
import 'package:easy_tracker/screens/sub_pages/add_edit_page.dart';
import 'package:easy_tracker/utils/entry_data.dart';
import 'package:easy_tracker/utils/entry_manager.dart';
import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/widgets/confirm_delete_dialog.dart';
import 'package:easy_tracker/widgets/entry_card.dart';

class ExpensePage extends StatefulWidget {
  final EntryManager entryManager;

  const ExpensePage({
    Key? key,
    required this.entryManager
  }): super(key: key);

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  Future<void> editExpData(BuildContext ctx, EntryData eD, EntryManager eM) async {
    EntryData newData = await Navigator.of(ctx).pushNamed(
        "/AddEditEntry",
        arguments: AddEditPageArguments(false, eD)
    ) as EntryData;
    if (newData.name != null) {
      eM.rmvExp(eD.id);
      if (newData.amount.isNegative) {
        newData.amount = -(newData.amount);
        await eM.addExp(newData);
      } else {
        await eM.addInc(newData);
      }
      if (ctx.mounted) {
        Navigator.of(ctx).pop();
      }
    }
  }

  Future<void> delExpData(BuildContext ctx, int index, EntryManager eM) async {
    bool shouldDelete = await showConfirmDeleteDialog(ctx);
    if (shouldDelete) {
      eM.rmvExp(index);
      if (ctx.mounted) {
        Navigator.of(ctx).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // extract arguments
    EntryManager data = ModalRoute.of(context)!.settings.arguments as EntryManager;

    int index = 0;
    List<Widget> wdgList = [];
    for (var entry in data.expList) {
      entry.id = index;
      wdgList.add(const SizedBox(height: 10));
      wdgList.add(
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.name as String,
                        style: bodyLarge
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/eva_arrow-down-fill.svg',
                            height: 24,
                            width: 24,
                          ),
                          Text(
                            formatUSD(entry.amount),
                            style: bodyNumMedium,
                          )
                        ]
                      ),
                      const SizedBox(height: 4),
                      Text(
                        timestampToDate(entry.timestamp),
                        style: bodyNumSmall,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        entry.description as String,
                        style: bodyMedium,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () async {
                              await editExpData(context, entry, data);
                              setState(() {});
                            },
                            style: txtBtnTheme,
                            child: const Text(
                              'Edit',
                              style: bodySmall
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await delExpData(context, entry.id, data);
                              setState(() {});
                            },
                            style: txtBtnTheme,
                            child: const Text(
                              'Delete',
                              style: bodySmallRed
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: txtBtnTheme,
                          child: const Text(
                            'Close',
                            style: bodySmall
                          ),
                        ),
                      )
                    ]
                  )
                )
              )
            );
          },
          child: EntryCard(
            id: index,
            name: entry.name!,
            amount: -(entry.amount),
            timestamp: entry.timestamp,
            description: entry.description!
          ),
        )
      );
      index++;
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