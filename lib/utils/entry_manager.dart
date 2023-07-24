// Standard
import 'dart:convert';

// 3rd-party Packages
import 'package:easy_tracker/utils/datetime_util.dart';
import 'package:firebase_database/firebase_database.dart';

// Local
import 'entry_data.dart';

// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

// Important Class that handles the read and write
// to and from Firebase Realtime Database
// using Firebase.instance.ref() object.

// LOCAL STORAGE PATH FUNCTIONS
// Commented out after database implementation
/* ===== ===== ===== ===== =====
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
===== ===== ===== ===== ===== */

class EntryManager{
  String uid;
  late DatabaseReference ref;

  List<EntryData> incList = [];
  List<EntryData> expList = [];

  // PRIVATE constructor
  EntryManager._(this.uid) {
    ref = FirebaseDatabase.instance.ref("users/$uid");
  }

  // Use this custom "constructor" to declare an instance
  // DART does not allow async constructors
  // so, this custom async "constructor" is used
  // to fake the async initialization of an instance
  static Future<EntryManager> create(String uid) async {
    EntryManager manager = EntryManager._(uid);
    await manager.readData();
    return manager;
  }

  // READ FROM & WRITE TO LOCAL STORAGE
  // Commented out after database implementation
  // Bad Code by the way, please don't try to read.
  /* ===== ===== ===== ===== =====
  Future<void> readLocal() async {
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
      readLocal();
    }
  }
  Future<void> writeLocal() async {
    final incFile = await _localIncFile;
    final expFile = await _localExpFile;
    final incData = incList.map((e) => e.toJson()).toList();
    final expData = expList.map((e) => e.toJson()).toList();
    final incJson = json.encode(incData);
    final expJson = json.encode(expData);
    await incFile.writeAsString(incJson);
    await expFile.writeAsString(expJson);
  }
  ===== ===== ===== ===== ===== */

  Future<void> readData() async {
    await readIncData();
    await readExpData();
  }

  Future<void> readIncData() async {
    final incSnap = await ref.child("inc").get();
    if (incSnap.exists) {
      final incListDynamic = json.decode(incSnap.value.toString()) as List<dynamic>;
      incList = incListDynamic.map((e) => EntryData.fromJson(e)).toList();
    }
  }

  Future<void> readExpData() async {
    final expSnap = await ref.child("exp").get();
    if (expSnap.exists) {
      final expListDynamic = json.decode(expSnap.value.toString()) as List<dynamic>;
      expList = expListDynamic.map((e) => EntryData.fromJson(e)).toList();
    }
  }

  Future<void> writeIncData() async {
    final incListMap = incList.map((e) => e.toJson()).toList();
    final incStr = json.encode(incListMap);
    await ref.child("inc").set(incStr);
  }

  Future<void> writeExpData() async {
    final expListMap = expList.map((e) => e.toJson()).toList();
    final expStr = json.encode(expListMap);
    await ref.child("exp").set(expStr);
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
    await writeIncData();
  }

  Future<void> addExp(EntryData newData) async {
    expList.add(newData);
    sortExpEntries();
    await writeExpData();
  }

  Future<void> rmvInc(int id) async {
    incList.removeAt(id);
    await writeIncData();
  }

  Future<void> rmvExp(int id) async {
    expList.removeAt(id);
    await writeExpData();
  }

  double calcIncThisMonth() {
    DateTime n = DateTime.now();
    double incThisMonth = 0.0;
    for (var e in incList) {
      DateTime eTime = fromSecondsSinceEpoch(e.timestamp);
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
      DateTime eTime = fromSecondsSinceEpoch(e.timestamp);
      if (eTime.month == n.month && eTime.year == n.year) {
        expThisMonth += e.amount;
      }
    }
    return expThisMonth;
  }
}