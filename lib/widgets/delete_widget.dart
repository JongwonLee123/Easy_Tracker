import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_tracker/utils/themes.dart';

class DeleteWidget extends StatelessWidget {
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Account"),
          content: Text("Are you sure you want to delete your account? This action cannot be undone."),
          actions: <Widget>[
            ElevatedButton(
              style: btnWhiteTheme.copyWith( // Copy btnWhiteTheme and modify properties
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              style: btnRedTheme, // Apply btnRedTheme
              onPressed: () async {
                await FirebaseAuth.instance.currentUser!.delete();
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Navigate back to the home page
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: btnRedTheme,
      onPressed: () {
        _showConfirmationDialog(context);
      },
      child: Text("Delete Account"),
    );
  }
}
