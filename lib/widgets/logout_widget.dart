import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogoutWidget extends StatelessWidget {
  void _logoutAndNavigateToHome(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context); // Navigate back to the previous screen (assuming home page is the previous screen)
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        primary: Colors.white, // Set the background color to white
        onPrimary: Colors.black, // Set the text color to black
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: () {
        _logoutAndNavigateToHome(context);
      },
      child: Text("Log Out"),
    );
  }
}
