import 'package:easy_tracker/utils/entry_data.dart';
import 'package:easy_tracker/utils/entry_manager.dart';
import 'package:easy_tracker/widgets/entry_card.dart';
import 'package:easy_tracker/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:easy_tracker/widgets/net_card.dart';
import 'package:easy_tracker/screens/sub_pages/income_page.dart';
import 'package:easy_tracker/screens/sub_pages/expense_page.dart';
import 'package:easy_tracker/screens/sub_pages/add_page.dart';

class HomePage extends StatefulWidget {

  const HomePage ({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> incWdgList = [];
  List<Widget> expWdgList = [];

  Future<EntryManager> prepareData() async {
    incWdgList = [];
    expWdgList = [];
    EntryManager d = await EntryManager.create();
    const int displayLimit = 2;
    int c = 0;
    if (d.incList.isEmpty) {
      incWdgList.add(const SizedBox(height: 10));
      incWdgList.add(const Text("No Data", style: bodySmall));
    }
    if (d.expList.isEmpty) {
      expWdgList.add(const SizedBox(height: 10));
      expWdgList.add(const Text("No Data", style: bodySmall));
    }
    for (var entry in d.incList) {
      if (c++ >= displayLimit) {break;}
      incWdgList.add(const SizedBox(height: 10));
      incWdgList.add(
        EntryCard(
          id: c - 1,
          name: entry.name!,
          amount: entry.amount,
          timestamp: entry.timestamp,
          description: entry.description!
        )
      );
    }
    c = 0;
    for (var entry in d.expList) {
      if (c++ >= displayLimit) {break;}
      expWdgList.add(const SizedBox(height: 10));
      expWdgList.add(
        EntryCard(
          id: c - 1,
          name: entry.name!,
          amount: -(entry.amount),
          timestamp: entry.timestamp,
          description: entry.description!
        )
      );
    }
    return d;
  }

  @override
  Widget build(BuildContext context) {
    Future<EntryData> addData(BuildContext context) async {
      return await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return const AddPage();
        })
      );
    }

    return FutureBuilder(
      future: prepareData(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(
            child: Text(
              "Error: ${data.error}",
              style: bodyMedium,
            ));
        } else if (data.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          EntryManager dataManager = data.data as EntryManager;
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: btnWhite,
              child: const Icon(
                Icons.add,
                color: Colors.black
              ),
              onPressed: () async {
                final EntryData result = await addData(context);
                if (result.name != null) {
                  EntryData newData = EntryData(
                    name: result.name,
                    amount: result.amount,
                    timestamp: result.timestamp,
                    description: result.description
                  );
                  if (result.amount.isNegative) {
                    newData.amount = -(newData.amount);
                    dataManager.addExp(newData);
                  } else {
                    dataManager.addInc(newData);
                  }
                  await dataManager.writeJson();
                }
                dataManager.loadJson();
                // Refresh
                setState(() {});
                // add new STUFF HERE!
              },
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NetCard(
                      income: dataManager.calcIncThisMonth(),
                      expense: dataManager.calcExpThisMonth(),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row( // display all text row
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Income",
                              style: bodyMedium,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return IncomePage(data: dataManager);
                                    }
                                  )
                                );
                              },
                              child: const Text(
                                "display all",
                                style: bodySmall,
                              )
                            )
                          ],
                        ),
                        Column(
                          children: incWdgList,
                        )
                      ]
                    ),
                    const SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row( // display all text row
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Expenses",
                              style: bodyMedium,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ExpensePage(data: dataManager);
                                    }
                                  )
                                );
                              },
                              child: const Text(
                                "display all",
                                style: bodySmall,
                              )
                            )
                          ],
                        ),
                        Column(
                          children: expWdgList,
                        )
                      ]
                    )
                  ],
                )
              )
            )
          );
        }
      }
    );
  }
}