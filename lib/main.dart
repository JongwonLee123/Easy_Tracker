// 3rd-party Packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// Local
import 'package:easy_tracker/login.dart';
import 'package:easy_tracker/screens/home.dart';
import 'package:easy_tracker/screens/main_page.dart';
import 'package:easy_tracker/screens/profile.dart';
import 'package:easy_tracker/screens/sub_pages/add_edit_page.dart';
import 'package:easy_tracker/screens/sub_pages/expense_page.dart';
import 'package:easy_tracker/screens/sub_pages/income_page.dart';
import 'package:easy_tracker/signup.dart';
import 'package:easy_tracker/utils/app_user.dart';
import 'package:easy_tracker/utils/entry_manager.dart';
import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/welcome.dart';

// The main dart file where the app starts.
// routes to the WelcomePage() from welcome.dart

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        "/Login": (context) => const LoginPage(),
        "/Signup": (context) => const SignupPage(),
        "/Main": (context) {
          final AppUser d = ModalRoute.of(context)?.settings.arguments as AppUser;
          return MainPage(appUser: d); // GO HERE
        },
        "/Home": (context) {
          final AppUser d = ModalRoute.of(context)?.settings.arguments as AppUser;
          return HomePage(appUser: d);
        },
        "/Profile": (context) => const ProfilePage(),
        "/AddEditEntry": (context) {
          final AddEditPageArguments d = ModalRoute.of(context)?.settings.arguments as AddEditPageArguments;
          return AddPage(addPageArguments: d);
        },
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
