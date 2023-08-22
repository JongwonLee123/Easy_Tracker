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
    AppUser u = widget.appUser;
    final pages = [
      HomePage(appUser: u),
      ProfilePage(appUser: u),
    ];
    return pages;
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldLogout = await showConfirmLogoutDialog(context);
        if (shouldLogout && context.mounted) {
          Navigator.of(context).popUntil(ModalRoute.withName("/"));
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
          // height: 60,
          backgroundColor: fgWhite,
          indicatorColor: Colors.black12,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: _currentIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, size: 30),
              selectedIcon: Icon(Icons.home_filled, size: 30),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outlined, size: 30),
              selectedIcon: Icon(Icons.person_rounded, size: 30),
              label: 'Profile',
            ),
          ],
        ),
        body: FutureBuilder(
          future: prepareData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Error: ${data.error}",
                    style: bodyMedium,
                  )
                )
              );
            } else if (data.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final pages = data.data as List<StatefulWidget>;
              return pages[_currentIndex];
            }
          }
        ),
      )
    );
  }
}