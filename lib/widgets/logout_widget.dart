import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/utils/app_user.dart';

class LogoutWidget extends StatelessWidget {
  final AppUser appUser; // Add the AppUser as a parameter

  LogoutWidget(this.appUser);
  void _logoutAndNavigateToHome(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // Create a new instance of AppUser after logout to clear the data
    // AppUser appUser = AppUser(this.appUser.email, this.appUser.name);
    // Navigate to the home page or any other appropriate page
    Navigator.pop(context);
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: btnWhiteTheme,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Log Out",
                style: bodyMedium,
              ),
              content: const Text(
                "Are you sure you want to log out?.",
                style: bodySmall,
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: btnWhiteTheme
                      .copyWith( // Copy btnWhiteTheme and modify properties
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text(
                    "Cancel",
                    style: bodySmall,
                  ),
                ),
                ElevatedButton(
                  style: btnRedTheme, // Apply btnRedTheme
                  onPressed: () async {
                    Navigator.of(context).pop();
                    _logoutAndNavigateToHome(context);
                  },
                  child: const Text(
                    "Log Out",
                    style: bodySmallWhite,
                  ),
                ),
              ],
            );
          },
        );
      },
      child: const Text(
        "Log Out",
        style: bodySmall,
      ),
    );
  }
}
