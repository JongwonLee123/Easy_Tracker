// 3rd-party Packages
import 'package:intl/intl.dart';

// The purpose of this module is to compress
// milliseconds to seconds
// Save 3 Zeroes and the Environment

String timestampToDate(int timestamp) {
  DateTime dt = DateTime.fromMillisecondsSinceEpoch(timestamp * Duration.millisecondsPerSecond);
  return DateFormat('MMM dd, yyyy, h:mma').format(dt);
}

DateTime fromSecondsSinceEpoch(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp * Duration.millisecondsPerSecond);
}

int secondsSinceEpoch(DateTime dt) {
  return (dt.millisecondsSinceEpoch / Duration.millisecondsPerSecond).round();
}
