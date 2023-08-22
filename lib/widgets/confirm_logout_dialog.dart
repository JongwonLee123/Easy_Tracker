// 3rd-party Packages
import 'package:flutter/material.dart';

// Local
import 'package:easy_tracker/utils/themes.dart';

// this thing returns true or false
// ===== WARNING =====
// handle logout from outside
// this does nothing inside

Future<bool> showConfirmLogoutDialog(BuildContext ctx) async {
  return await showDialog(
    context: ctx,
    builder: (BuildContext context) {
      return const ConfirmLogoutDialog();
    }
  );
}

class ConfirmLogoutDialog extends StatelessWidget {
  const ConfirmLogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(false);
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Logging out of your account.",
                      style: bodyMedium,
                    ),const Text(
                      "Are you sure?",
                      style: bodyMedium,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          style: txtBtnTheme,
                          child: const Text(
                              'No',
                              style: bodySmall
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          style: txtBtnTheme,
                          child: const Text(
                              'Yes',
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