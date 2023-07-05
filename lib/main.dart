import 'package:flutter/material.dart';
import 'package:easy_tracker/welcome.dart';

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
        scaffoldBackgroundColor: const Color(0xFFD0DDD7),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w900,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w500,
          ),
          bodySmall: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: const WelcomePage(),
    );
  }
}
