// 3rd-party Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Local
import 'package:easy_tracker/screens/home.dart';
import 'package:easy_tracker/screens/profile.dart';
import 'package:easy_tracker/utils/app_user.dart';
import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/widgets/confirm_logout_dialog.dart';

// This MainPage handles the main navigation
// throughout the app.
// Made up of only AppBar and NavigationBar.
// Will call other Pages to fill up its body.

// Wrapped with WillPopScope
// OnWillPop will automatically log out of the user's account
// This is to handle "back button" behavior in Android, etc.

class MainPage extends StatefulWidget {
  final AppUser appUser;

  const MainPage({
    Key? key,
    required this.appUser
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<List<StatefulWidget>> prepareData() async {
    AppUser u = ModalRoute.of(context)!.settings.arguments as AppUser;
    final pages = [
      HomePage(appUser: u),
      const ProfilePage(),
    ];
    return pages;
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldLogout = await showConfirmLogoutDialog(context);
        if (shouldLogout && context.mounted) {
          Navigator.of(context).pop();
          await FirebaseAuth.instance.signOut();
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: fgWhite,
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: NavigationBar(
          height: 60,
          selectedIndex: currentIndex,
          backgroundColor: fgWhite,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          onDestinationSelected: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
        body: FutureBuilder(
          future: prepareData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(
                child: Text(
                  "Error: ${data.error}",
                  style: bodyMedium,
                )
              );
            } else if (data.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final pages = data.data as List<StatefulWidget>;
              return pages[currentIndex];
            }
          }
        ),
      )
    );
  }
}