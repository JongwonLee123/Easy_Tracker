// 3rd-party Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Local
import 'package:easy_tracker/utils/app_user.dart';
import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/widgets/blank_snack_bar.dart';
import 'package:easy_tracker/widgets/confirm_psd_change_dialog.dart';
import 'package:easy_tracker/widgets/simple_dialog.dart';

Future<void> showPasswordChangeDialog(BuildContext ctx, AppUser appUser) async {
  return await showDialog(
    context: ctx,
    builder: (BuildContext context) {
      return PasswordChangeDialog(appUser: appUser);
    }
  );
}

class PasswordChangeDialog extends StatefulWidget {
  final AppUser appUser;

  const PasswordChangeDialog({
    Key? key,
    required this.appUser
  }) : super(key: key);

  @override
  State<PasswordChangeDialog> createState() => _PasswordChangeDialogState();
}

class _PasswordChangeDialogState extends State<PasswordChangeDialog> {
  TextEditingController oldPsdController = TextEditingController();
  TextEditingController newPsdController = TextEditingController();
  TextEditingController newPsdConfirmController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Change Password?",
                style: bodyBig,
              ),
              Text(
                "Please re-enter the password for "
                    "email address ${currentUser.email!} "
                    "to confirm the process.",
                style: bodyMedium,
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: TextField(
                  controller: oldPsdController,
                  obscureText: true,
                  decoration: customInputDecoWithLabel("Old Password")
                )
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: TextField(
                  controller: newPsdController,
                  obscureText: true,
                  decoration: customInputDecoWithLabel("New Password")
                )
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: TextField(
                  controller: newPsdConfirmController,
                  obscureText: true,
                  decoration: customInputDecoWithLabel("Confirm New Password")
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(null);
                    },
                    style: txtBtnTheme,
                    child: const Text(
                      'Cancel',
                      style: bodySmall
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      String oldPsd = oldPsdController.text;
                      String newPsd = newPsdController.text;
                      String newPsdC = newPsdConfirmController.text;
                      if (oldPsd.isEmpty) {
                        if (context.mounted) {
                          await showSimpleDialog(
                            context,
                            "Please enter password."
                          );
                        }
                        return;
                      }
                      if (oldPsd.contains(" ")) {
                        if (context.mounted) {
                          await showSimpleDialog(
                            context,
                            "Password must not contain spaces."
                          );
                        }
                        return;
                      }
                      try {
                        final credential = EmailAuthProvider.credential(
                          email: currentUser.email!,
                          password: oldPsd
                        );
                        await currentUser.reauthenticateWithCredential(credential);
                      } on FirebaseAuthException {
                        await showSimpleDialog(
                          context,
                          "Wrong Password."
                        );
                        return;
                      }
                      if (newPsd.isEmpty) {
                        if (context.mounted) {
                          await showSimpleDialog(
                            context,
                            "Please enter new password."
                          );
                        }
                        return;
                      }
                      if (newPsdC.isEmpty) {
                        if (context.mounted) {
                          await showSimpleDialog(
                            context,
                            "Please confirm new password."
                          );
                        }
                        return;
                      }
                      if (newPsd != newPsdC) {
                        if (context.mounted) {
                          await showSimpleDialog(
                            context,
                            "New passwords do not match."
                          );
                        }
                        return;
                      }
                      if (newPsd.contains(" ")) {
                        if (context.mounted) {
                          await showSimpleDialog(
                            context,
                            "Passwords must not contain spaces."
                          );
                        }
                        return;
                      }
                      try {
                        bool shouldChange = false;
                        if (context.mounted) {
                          shouldChange = await showConfirmPsdChangeDialog(context);
                        }
                        if (shouldChange) {
                          currentUser.updatePassword(newPsd);
                          if (context.mounted) {
                            await showSimpleDialog(
                              context,
                              "Password Successfully Updated!\n"
                                  "We will log out of your account for security.\n"
                                  "Please Log in again to use the app."
                            );
                          }
                          await FirebaseAuth.instance.signOut();
                          if (context.mounted) {
                            Navigator.of(context).popUntil(ModalRoute.withName("/"));
                            showBlankSnackBar(
                              context,
                              "Password successfully Changed"
                            );
                          }
                          return;
                        }
                      } on FirebaseAuthException catch (e) {
                        if (context.mounted) {
                          await showSimpleDialog(
                            context,
                            e.message.toString()
                          );
                        }
                        return;
                      }
                    },
                    style: txtBtnTheme,
                    child: const Text(
                      'Confirm',
                      style: bodySmallGreen
                    ),
                  ),
                ],
              )
            ]
          )
        ),
      )
    );
  }
}