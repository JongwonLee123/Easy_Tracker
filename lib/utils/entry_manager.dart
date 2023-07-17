import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'entry_data.dart';
import 'dart:convert';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localIncFile async {
  final path = await _localPath;
  return File("$path/income.json");
}

Future<File> get _localExpFile async {
  final path = await _localPath;
  return File("$path/expense.json");
}

void createFiles() async {
  final path = await _localPath;
  final incomeFile = File("$path/income.json");
  final expenseFile = File("$path/expense.json");

  if (!await incomeFile.exists()) {
    await incomeFile.create(recursive: true);
  }

  if (!await expenseFile.exists()) {
    await expenseFile.create(recursive: true);
  }
}

class EntryManager{
  List<EntryData> incList = [];
  List<EntryData> expList = [];
  EntryManager._();

  static Future<EntryManager> create() async {
    EntryManager manager = EntryManager._();
    await manager.loadJson();
    return manager;
  }

  Future<void> loadJson() async {
    final incFile = await _localIncFile;
    final expFile = await _localExpFile;
    try {
      final incJson = await incFile.readAsString();
      final expJson = await expFile.readAsString();
      final incData = json.decode(incJson) as List<dynamic>;
      final expData = json.decode(expJson) as List<dynamic>;
      incList = incData.map((e) => EntryData.fromJson(e)).toList();
      expList = expData.map((e) => EntryData.fromJson(e)).toList();
    } on PathNotFoundException {
      createFiles();
      final incData = incList.map((e) => e.toJson()).toList();
      final expData = expList.map((e) => e.toJson()).toList();
      final incJson = json.encode(incData);
      final expJson = json.encode(expData);
      await incFile.writeAsString(incJson);
      await expFile.writeAsString(expJson);
      loadJson();
    }
  }

  Future<void> writeJson() async {
    final incFile = await _localIncFile;
    final expFile = await _localExpFile;
    final incData = incList.map((e) => e.toJson()).toList();
    final expData = expList.map((e) => e.toJson()).toList();
    final incJson = json.encode(incData);
    final expJson = json.encode(expData);
    await incFile.writeAsString(incJson);
    await expFile.writeAsString(expJson);
  }

  void sortIncEntries() {
    incList.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }
  void sortExpEntries() {
    expList.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Future<void> addInc(EntryData newData) async {
    incList.add(newData);
    sortIncEntries();
    await writeJson();
  }

  Future<void> addExp(EntryData newData) async {
    expList.add(newData);
    sortExpEntries();
    await writeJson();
  }

  Future<void> rmvInc(int id) async {
    incList.removeAt(id);
    await writeJson();
  }

  Future<void> rmvExp(int id) async {
    expList.removeAt(id);
    await writeJson();
  }

  double calcIncThisMonth() {
    DateTime n = DateTime.now();
    double incThisMonth = 0.0;
    for (var e in incList) {
      DateTime eTime = DateTime.fromMillisecondsSinceEpoch(e.timestamp);
      if (eTime.month == n.month && eTime.year == n.year) {
        incThisMonth += e.amount;
      }
    }
    return incThisMonth;
  }

  double calcExpThisMonth() {
    DateTime n = DateTime.now();
    double expThisMonth = 0.0;
    for (var e in expList) {
      DateTime eTime = DateTime.fromMillisecondsSinceEpoch(e.timestamp);
      if (eTime.month == n.month && eTime.year == n.year) {
        expThisMonth += e.amount;
      }
    }
    return expThisMonth;
  }
}