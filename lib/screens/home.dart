import 'package:easy_tracker/utils/entry_manager.dart';
import 'package:easy_tracker/widgets/entry_card.dart';
import 'package:easy_tracker/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:easy_tracker/widgets/net_card.dart';
import 'package:easy_tracker/screens/display_all/income_page.dart';
import 'package:easy_tracker/screens/display_all/expense_page.dart';

class HomePage extends StatefulWidget {

  const HomePage ({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<EntryManager> readData() async {
    return EntryManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: btnWhite,
        child: const Icon(Icons.add, color: Colors.black,),
        onPressed: () {},
      ),
      body: FutureBuilder(
        future: readData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("Error ${data.error}"));
          } else if (data.hasData) {
            EntryManager dataALL = data.data as EntryManager;
            dataALL.calcIncThisMonth();
            dataALL.calcExpThisMonth();
            List<Widget> incWdgList = [];
            List<Widget> expWdgList = [];
            const int displayLimit = 2;
            int c = 0;
            for (var entry in dataALL.incList) {
              if (c++ >= displayLimit) {
                break;
              }
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
            for (var entry in dataALL.expList) {
              if (c++ >= displayLimit) {
                break;
              }
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

            return Container(
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
                      income: dataALL.incThisMonth,
                      expense: dataALL.expThisMonth,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return IncomePage(data: dataALL);
                                  })
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ExpensePage(data: dataALL);
                                  })
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
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      )
    );
  }
}
