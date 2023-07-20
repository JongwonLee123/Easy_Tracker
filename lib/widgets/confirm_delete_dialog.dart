import 'package:flutter/material.dart';
import 'package:easy_tracker/utils/themes.dart';

// this thing returns true or false
// handle that from outside
// this does nothing inside

class ConfirmDeleteDialog extends StatelessWidget {
  const ConfirmDeleteDialog({super.key});

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
                "This action can't be undone.",
                style: bodyMedium,
              ),
              const Text(
                "Delete this Record?",
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
                      'Cancel',
                      style: bodySmall
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
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