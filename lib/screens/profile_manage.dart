// 3rd-party Packages
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// Local
import 'package:easy_tracker/utils/app_user.dart';
import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/widgets/account_deletion_dialog.dart';
import 'package:easy_tracker/widgets/confirm_delete_dialog.dart';
import 'package:easy_tracker/widgets/password_change_dialog.dart';
import 'package:easy_tracker/widgets/simple_dialog.dart';

class ProfileManagePage extends StatelessWidget {
  final AppUser appUser;

  const ProfileManagePage({Key? key, required this.appUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manage Profile",
          style: bodyMedium,
        ),
        backgroundColor: fgWhite,
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.black,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                const Text(
                  "Update your account's security by "
                      "updating your password.",
                  style: bodyMedium
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child:
                  ElevatedButton(
                    onPressed: () async {
                      await showPasswordChangeDialog(context, appUser);
                    },
                    style: btnWhiteTheme,
                    child: const Text(
                      "Change Password",
                      style: bodyMedium,
                    ),
                  )
                ),
                const SizedBox(height: 10),
                const Divider(),
                const Text(
                  "Free up cloud storage and "
                      "remove all your account data.",
                  style: bodyMedium
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child:
                  ElevatedButton(
                    onPressed: () async {
                      bool shouldDelete = await showConfirmDeleteDialog(
                        context,
                        "Delete all Data?"
                      );
                      if (shouldDelete) {
                        if (context.mounted) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext ctx) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: fgWhite,
                                )
                              );
                            }
                          );
                        }
                        DatabaseReference ref = FirebaseDatabase.instance.ref(
                          "users/${appUser.uid}"
                        );
                        await ref.child("inc").set(null);
                        await ref.child("exp").set(null);
                        if (context.mounted) {
                          await showSimpleDialog(
                            context,
                            "All Data has been deleted"
                          );
                        }
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    style: btnRedTheme,
                    child: const Text(
                      "Delete All Data",
                      style: bodyMedium,
                    ),
                  )
                ),
                const SizedBox(height: 10),
                const Divider(),
                const Text(
                  "Permanently remove your account "
                      "and all associated data.",
                  style: bodyMedium
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child:
                  ElevatedButton(
                    onPressed: () async {
                      await showAccountDeletionDialog(context, appUser);
                    },
                    style: btnRedTheme,
                    child: const Text(
                      "Delete Account",
                      style: bodyMedium,
                    ),
                  )
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}