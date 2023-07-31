// 3rd-party Packages
import 'package:flutter/material.dart';

// Local
import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/widgets/simple_dialog.dart';

// this thing returns null or string
// ===== WARNING =====
// handle edit from outside
// this does nothing inside

Future<String?> showUsernameEditDialog(BuildContext ctx) async {
  return await showDialog(
    context: ctx,
    builder: (BuildContext context) {
      return const UsernameEditDialog();
    }
  );
}

class UsernameEditDialog extends StatefulWidget {
  const UsernameEditDialog({Key? key}) : super(key: key);

  @override
  State<UsernameEditDialog> createState() => _UsernameEditDialogState();
}

class _UsernameEditDialogState extends State<UsernameEditDialog> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(null);
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
                "Please type in your new Username.",
                style: bodyMedium,
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: TextField(
                  controller: nameController,
                  decoration: customInputDecoWithLabel("New Username")
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop("");
                    },
                    child: const Text(
                      'Clear Name',
                      style: bodySmall,
                    )
                  )
                ],
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
                      String newName = nameController.text.trim();
                      if (newName == "") {
                        await showSimpleDialog(
                          context,
                          "Username cannot be empty.\n"
                              "To delete the username, "
                              "click the \"Clear Name\" button."
                        );
                        return;
                      }
                      if (newName.length > 16) {
                        await showSimpleDialog(
                          context,
                          "Username can't be longer than 16 characters."
                        );
                        return;
                      }
                      Navigator.of(context).pop(nameController.text.trim());
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