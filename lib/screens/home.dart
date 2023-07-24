// 3rd-party Packages
import 'package:flutter/material.dart';

// Local
import 'package:easy_tracker/screens/sub_pages/add_edit_page.dart';
import 'package:easy_tracker/utils/app_user.dart';
import 'package:easy_tracker/utils/entry_data.dart';
import 'package:easy_tracker/utils/entry_manager.dart';
import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/widgets/entry_card.dart';
import 'package:easy_tracker/widgets/net_card.dart';

class HomePage extends StatefulWidget {
  final AppUser appUser;

  const HomePage ({
    Key? key,
    required this.appUser
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> incWdgList = [];
  List<Widget> expWdgList = [];

  Future<EntryManager> prepareData() async {
    incWdgList = [];
    expWdgList = [];
    EntryManager d = await EntryManager.create(widget.appUser.uid);
    const int displayLimit = 2;
    if (d.incList.isEmpty) {
      incWdgList.add(const SizedBox(height: 10));
      incWdgList.add(const Text("No Data", style: bodyMedium));
    }
    if (d.expList.isEmpty) {
      expWdgList.add(const SizedBox(height: 10));
      expWdgList.add(const Text("No Data", style: bodyMedium));
    }
    int c = 0;
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

    Future<EntryData> addData(BuildContext context, AddEditPageArguments nullData) async {
      return await Navigator.of(context).pushNamed(
        "/AddEditEntry",
        arguments: nullData
      ) as EntryData;
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
                // nullData is required to supply the AddPage()
                EntryData nullData = EntryData(
                  id: -1,
                  amount: 0,
                  timestamp: 0,
                );
                final EntryData returnData = await addData(
                  context,
                  AddEditPageArguments(true, nullData)
                );
                if (returnData.name != null) {
                  if (returnData.amount.isNegative) {
                    returnData.amount = -(returnData.amount);
                    await dataManager.addExp(returnData);
                  } else {
                    await dataManager.addInc(returnData);
                  }
                }
                setState(() {}); // REFRESHER
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
                    const SizedBox(height: 10),
                    const Divider(),
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
                            SizedBox(
                              height: 30,
                              child: TextButton(
                                style: txtBtnTheme,
                                onPressed: () async {
                                  await Navigator.of(context).pushNamed(
                                    "/Income",
                                    arguments: dataManager,
                                  );
                                  setState(() {}); // REFRESHER
                                },
                                child: const Text(
                                  "display all",
                                  style: bodySmall,
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: incWdgList,
                        )
                      ]
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
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
                            SizedBox(
                              height: 30,
                              child: TextButton(
                                style: txtBtnTheme,
                                onPressed: () async {
                                  await Navigator.of(context).pushNamed(
                                    "/Expense",
                                    arguments: dataManager
                                  );
                                  setState(() {}); // REFRESHER
                                },
                                child: const Text(
                                  "display all",
                                  style: bodySmall,
                                ),
                              ),
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