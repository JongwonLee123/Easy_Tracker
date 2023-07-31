import 'package:flutter/material.dart';
import 'package:easy_tracker/utils/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/screens/profile_edit.dart';

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
  State<ProfileWidget> createState() => _ProfileWidgetState();
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
                const SizedBox(height: 20),
                const ImageWidget(size: 150),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8),
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
                          _navigateToEditPage(context, EditFieldType.username);

                        },
                      ),
                      const SizedBox(height: 10),
                      EmailWidget(email: widget.appUser.email), // Use appUser.email
                      const SizedBox(height: 20),
                      PasswordWidget(
                        onChangePassword: () {
                          _navigateToEditPage(context, EditFieldType.password);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 100),
                          DeleteWidget(),
                          const SizedBox(width: 20),
                          LogoutWidget(widget.appUser),
                          const SizedBox(height: 20),
                        ],
                      ),
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
    String initialValue = (fieldType == EditFieldType.username) ? widget.appUser.name ?? '' : '';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNamePage(
          fieldType: fieldType,
          initialValue: initialValue,
          onSaveValue: (newValue) async {
            if (fieldType == EditFieldType.username) {
              // Update the username in the appUser instance
              widget.appUser.name = newValue;

              // Update the display name in FirebaseAuth
              try {
                await FirebaseAuth.instance.currentUser!.updateDisplayName(newValue);
                debugPrint('Display name updated in FirebaseAuth.');
              } catch (e) {
                debugPrint('Error updating display name in FirebaseAuth: $e');
              }

              // Update the name in the Firebase Realtime Database
              try {
                DatabaseReference ref = FirebaseDatabase.instance.ref("users/${widget.appUser.uid}");
                await ref.child("username").set(newValue);
                debugPrint('Name updated in Firebase Realtime Database.');
              } catch (e) {
                debugPrint('Error updating name in Firebase Realtime Database: $e');
              }
            } else {
              // Update the password using FirebaseAuth
              try {
                await FirebaseAuth.instance.currentUser!.updatePassword(newValue);
                debugPrint('Password updated in FirebaseAuth.');
              } catch (e) {
                debugPrint('Error updating password in FirebaseAuth: $e');
              }
            }
            setState(() {});
          },
        ),
      ),
    );
  }
}
