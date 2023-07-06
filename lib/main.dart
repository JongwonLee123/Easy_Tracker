import 'package:flutter/material.dart';
import 'package:easy_tracker/welcome.dart';
import 'package:easy_tracker/utils/themes.dart';

// The main dart file where the app starts.
// routes to the WelcomePage() from welcome.dart

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
      ),
      home: const WelcomePage(),
    );
  }
}
