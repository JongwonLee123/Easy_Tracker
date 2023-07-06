import 'dart:math';

import 'package:easy_tracker/widgets/entry_card.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:easy_tracker/utils/entry_data.dart';
import 'package:easy_tracker/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:easy_tracker/widgets/net_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<List<EntryData>>> readJsonData() async {
    final incJson = await rootBundle.loadString('data/json/income.json');
    final expJson = await rootBundle.loadString('data/json/expense.json');
    final incList = json.decode(incJson) as List<dynamic>;
    final expList = json.decode(expJson) as List<dynamic>;
    List<List<EntryData>> data = [];
    data.add(incList.map((e) => EntryData.fromJson(e)).toList());
    data.add(expList.map((e) => EntryData.fromJson(e)).toList());
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: readJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("Error: ${data.error}"));
          } else if (data.hasData) {

            var entryList = data.data as List<List<EntryData>>;
            var incEntryList = entryList[0];
            var expEntryList = entryList[1];
            List<Widget> incWdgList = [];
            List<Widget> expWdgList = [];
            double inc = 0;
            double exp = 0;
            const int displayLimit = 4;
            int c = 0;
            for (var entry in incEntryList) {
              inc += entry.amount;
              if (c++ < displayLimit) {
                incWdgList.add(const SizedBox(height: 10));
                incWdgList.add(
                  EntryCard(
                    name: entry.name!,
                    amount: entry.amount,
                    timestamp: entry.timestamp,
                    description: entry.description!
                  )
                );
              }
            }
            c = 0;
            for (var entry in expEntryList) {
              exp += entry.amount;
              if (c++ < displayLimit) {
                expWdgList.add(const SizedBox(height: 10));
                expWdgList.add(
                  EntryCard(
                    name: entry.name!,
                    amount: -(entry.amount),
                    timestamp: entry.timestamp,
                    description: entry.description!
                  )
                );
              }
            }

            return Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NetCard(
                      income: inc,
                      expense: exp,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Row( // display all text row
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Income",
                              style: bodyMedium,
                            ),
                            Text(
                              "display all",
                              style: bodySmall,
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
                        const Row( // display all text row
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Expense",
                              style: bodyMedium,
                            ),
                            Text(
                              "display all",
                              style: bodySmall,
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
        },
      ),
    );
  }
}
