// 3rd-party Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// Local
import 'package:easy_tracker/utils/app_user.dart';
import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/widgets/blank_snack_bar.dart';
import 'package:easy_tracker/widgets/confirm_delete_dialog.dart';
import 'package:easy_tracker/widgets/simple_dialog.dart';

Future<void> showAccountDeletionDialog(BuildContext ctx, AppUser appUser) async {
  return await showDialog(
    context: ctx,
    builder: (BuildContext context) {
      return AccountDeletionDialog(appUser: appUser);
    }
  );
}

class AccountDeletionDialog extends StatefulWidget {
  final AppUser appUser;

  const AccountDeletionDialog({
    Key? key,
    required this.appUser
  }) : super(key: key);

  @override
  State<AccountDeletionDialog> createState() => _AccountDeletionDialogState();
}

class _AccountDeletionDialogState extends State<AccountDeletionDialog> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                "Delete Account?",
                style: bodyBig,
              ),
              const Text(
                "Please re-enter your email address "
                    "registered with this account and "
                    "password to confirm the process.",
                style: bodyMedium,
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: TextField(
                  controller: emailController,
                  decoration: customInputDecoWithLabel("Email")
                )
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: customInputDecoWithLabel("Password")
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
                      String email = emailController.text.trim();
                      String password = passwordController.text;
                      if (email.isEmpty) {
                        await showSimpleDialog(
                          context,
                          "Please enter your Email."
                        );
                        return;
                      }
                      if (password.isEmpty) {
                        await showSimpleDialog(
                          context,
                          "Please enter password."
                        );
                        return;
                      }
                      if (password.contains(" ")) {
                        await showSimpleDialog(
                          context,
                          "Password must not contain spaces."
                        );
                        return;
                      }
                      try {
                        final currentUser = FirebaseAuth.instance.currentUser!;
                        final credential = EmailAuthProvider.credential(
                            email: email,
                            password: password
                        );
                        await currentUser.reauthenticateWithCredential(credential);
                        bool shouldDelete = false;
                        if (context.mounted) {
                          shouldDelete = await showConfirmDeleteDialog(
                            context,
                            "Are you sure you want to delete this account forever?"
                          );
                        }
                        if (shouldDelete) {
                          await FirebaseDatabase.instance.ref("users/${widget.appUser.uid}").set(null);
                          await currentUser.delete();
                          if (context.mounted) {
                            Navigator.of(context).popUntil(ModalRoute.withName("/"));
                            showBlankSnackBar(
                              context,
                              "Account successfully Deleted"
                            );
                          }
                        }
                      } on FirebaseAuthException {
                        await showSimpleDialog(
                          context,
                          "Invalid Email or Password"
                        );
                        return;
                      }
                    },
                    style: txtBtnTheme,
                    child: const Text(
                      'Confirm',
                      style: bodySmallRed
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