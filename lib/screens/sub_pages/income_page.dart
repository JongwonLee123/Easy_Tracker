// 3rd-party Packages
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Local
import 'package:easy_tracker/screens/sub_pages/add_edit_page.dart';
import 'package:easy_tracker/utils/datetime_util.dart';
import 'package:easy_tracker/utils/entry_data.dart';
import 'package:easy_tracker/utils/entry_manager.dart';
import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/widgets/blank_snack_bar.dart';
import 'package:easy_tracker/widgets/confirm_delete_dialog.dart';
import 'package:easy_tracker/widgets/entry_card.dart';

class IncomePage extends StatefulWidget {
  final EntryManager entryManager;

  const IncomePage({
    Key? key,
    required this.entryManager
  }): super(key: key);

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  Future<void> editIncData(BuildContext ctx, EntryData eD, EntryManager eM) async {
    EntryData newData = await Navigator.of(ctx).pushNamed(
        "/AddEditEntry",
        arguments: AddEditPageArguments(true, eD)
    ) as EntryData;
    if (newData.name != null) {
      await eM.rmvInc(eD.id);
      if (newData.amount.isNegative) {
        newData.amount = -(newData.amount);
        await eM.addExp(newData);
      } else {
        await eM.addInc(newData);
      }
      if (ctx.mounted) {
        showBlankSnackBar(ctx, "Data Updated");
        Navigator.of(ctx).pop(newData);
      }
    }
  }

  Future<void> delIncData(BuildContext ctx, int index, EntryManager eM) async {
    bool shouldDelete = await showConfirmDeleteDialog(ctx);
    if (shouldDelete) {
      eM.rmvInc(index);
      if (ctx.mounted) {
        showBlankSnackBar(ctx, "Data Deleted");
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
    for (var entry in data.incList) {
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
                            'assets/svg/eva_arrow-up-fill.svg',
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
                      const Divider(),
                      Text(
                        entry.description as String,
                        style: bodyMedium,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () async {
                              await editIncData(context, entry, data);
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
                              await delIncData(context, entry.id, data);
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
            amount: entry.amount,
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
          "Income",
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
                "No Income Entry!\nTry adding some",
                style: bodyMedium,
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