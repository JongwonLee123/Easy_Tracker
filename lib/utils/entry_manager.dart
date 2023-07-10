import 'entry_data.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class EntryManager{
  List<EntryData> incList = [];
  List<EntryData> expList = [];
  double incThisMonth = 0;
  double expThisMonth = 0;

  EntryManager();

  void loadJson() async {
    final incJson = await rootBundle.loadString('data/json/income.json');
    final expJson = await rootBundle.loadString('data/json/expense.json');
    final incData = json.decode(incJson) as List<dynamic>;
    final expData = json.decode(expJson) as List<dynamic>;
    incList = incData.map((e) => EntryData.fromJson(e)).toList();
    expList = expData.map((e) => EntryData.fromJson(e)).toList();
  }

  void calcIncThisMonth() {
    DateTime n = DateTime.now();
    for (var e in incList) {
      DateTime eTime = DateTime.fromMillisecondsSinceEpoch(e.timestamp);
      if (eTime.month == n.month && eTime.year == n.year) {
        incThisMonth += e.amount;
      }
    }
  }

  void calcExpThisMonth() {
    DateTime n = DateTime.now();
    for (var e in expList) {
      DateTime eTime = DateTime.fromMillisecondsSinceEpoch(e.timestamp);
      if (eTime.month == n.month && eTime.year == n.year) {
        expThisMonth += e.amount;
      }
    }
  }
}