import 'package:easy_tracker/screens/home.dart';
import 'package:easy_tracker/screens/profile.dart';
import 'package:easy_tracker/utils/entry_manager.dart';
import 'package:easy_tracker/utils/themes.dart';
import 'package:flutter/material.dart';

// this main_page.dart handles the main navigation
// throughout the app.

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final pages = [
    const HomePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: fgWhite,
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
      body: pages[currentIndex],
    );
  }
}