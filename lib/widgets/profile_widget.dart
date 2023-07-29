import 'package:flutter/material.dart';
import 'package:easy_tracker/utils/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/screens/profile_edit.dart';

enum EditFieldType {
  Password,
  Username,
}

class ProfileWidget extends StatelessWidget {
  final String email;
  final String? name;
  final AppUser appUser;
  final Function(String) onUpdateName; // Add this line to accept the onUpdateName parameter

  const ProfileWidget({
    Key? key,
    required this.email,
    this.name,
    required this.appUser,
    required this.onUpdateName, // Add this line to accept the onUpdateName parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: bodyMedium,
        ),
        backgroundColor: bgColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Name: ${name ?? 'N/A'}",
                  style: bodyMedium,
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _navigateToEditPage(context, EditFieldType.Username);
                  },
                  child: Text('Edit'),
                  style: mainBtnTheme,
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Email: $email",
              style: bodyMedium,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _navigateToEditPage(context, EditFieldType.Password);
              },
              child: Text("Change Password"),
              style: mainBtnTheme,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.currentUser!.delete();
              },
              child: Text("Delete Account"),
              style: btnRedTheme,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: Text("Log Out"),
              style: mainBtnTheme,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToEditPage(BuildContext context, EditFieldType fieldType) {
    String initialValue = (fieldType == EditFieldType.Username) ? appUser.name ?? '' : '';
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNamePage(
          fieldType: fieldType,
          initialValue: initialValue,
          onSaveValue: (newValue) {
            if (fieldType == EditFieldType.Username) {
              // Save the new username
            } else {
              // Update the password using FirebaseAuth
              FirebaseAuth.instance.currentUser!.updatePassword(newValue);
            }
            Navigator.pop(context); // Close the EditNamePage
          },
        ),
      ),
    );
  }
}


