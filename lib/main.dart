import 'package:easy_tracker/screens/home.dart';
import 'package:easy_tracker/screens/main_page.dart';
import 'package:easy_tracker/screens/profile.dart';
import 'package:easy_tracker/screens/sub_pages/add_page.dart';
import 'package:easy_tracker/screens/sub_pages/expense_page.dart';
import 'package:easy_tracker/screens/sub_pages/income_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_tracker/welcome.dart';
import 'package:easy_tracker/test/themes.dart';
import 'package:easy_tracker/utils/entry_manager.dart';

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
      initialRoute: "/",
      routes: {
        "/": (context) => const WelcomePage(),
        "/Main": (context) => const MainPage(),
        "/Home": (context) => const HomePage(),
        "/Profile": (context) => ProfilePage(),
        "/AddEntry": (context) => const AddPage(),
        "/Expense": (context) {
          final EntryManager d = ModalRoute.of(context)?.settings.arguments as EntryManager;
          return ExpensePage(entryManager: d);
        },
        "/Income": (context) {
          final EntryManager d = ModalRoute.of(context)?.settings.arguments as EntryManager;
          return IncomePage(entryManager: d);
        },
      },
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
      ),
    );
  }
}
