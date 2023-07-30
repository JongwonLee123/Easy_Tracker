import 'package:flutter/material.dart';
import 'package:easy_tracker/utils/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/screens/profile_edit.dart';

import 'package:easy_tracker/screens/main_page.dart';

import 'package:easy_tracker/widgets/image_widget.dart';
import 'package:easy_tracker/widgets/username_widget.dart';
import 'package:easy_tracker/widgets/email_widget.dart';
import 'package:easy_tracker/widgets/password_widget.dart';
import 'package:easy_tracker/widgets/delete_widget.dart';
import 'package:easy_tracker/widgets/logout_widget.dart';

class ProfileWidget extends StatefulWidget {
  final String email;
  final String? name;
  final AppUser appUser;

  const ProfileWidget({
    Key? key,
    required this.email,
    this.name,
    required this.appUser,
  }) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Wrap with SingleChildScrollView here
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                ImageWidget(size: 150),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: fgWhite.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UsernameWidget(
                        name: widget.appUser.name, // Use appUser.name
                        onEdit: () {
                          _navigateToEditPage(context, EditFieldType.Username);
                        },
                      ),
                      SizedBox(height: 10),
                      EmailWidget(email: widget.appUser.email), // Use appUser.email
                      SizedBox(height: 20),
                      PasswordWidget(
                        onChangePassword: () {
                          _navigateToEditPage(context, EditFieldType.Password);
                        },
                      ),
                      SizedBox(height: 20),
                      DeleteWidget(),
                      SizedBox(height: 20),
                      LogoutWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToEditPage(BuildContext context, EditFieldType fieldType) {
    String initialValue = (fieldType == EditFieldType.Username) ? widget.appUser.name ?? '' : '';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNamePage(
          fieldType: fieldType,
          initialValue: initialValue,
          onSaveValue: (newValue) async {
            if (fieldType == EditFieldType.Username) {
              // Update the username in the appUser instance
              widget.appUser.name = newValue;

              // Update the display name in FirebaseAuth
              try {
                await FirebaseAuth.instance.currentUser!.updateDisplayName(newValue);
                print('Display name updated in FirebaseAuth.');
              } catch (e) {
                print('Error updating display name in FirebaseAuth: $e');
              }
            } else {
              // Update the password using FirebaseAuth
              try {
                await FirebaseAuth.instance.currentUser!.updatePassword(newValue);
                print('Password updated in FirebaseAuth.');
              } catch (e) {
                print('Error updating password in FirebaseAuth: $e');
              }
            }
            Navigator.pop(context); // Close the EditNamePage
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => MainPage(appUser: widget.appUser)),
            // );
          },
        ),
      ),
    );
  }
}
