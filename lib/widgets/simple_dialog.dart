// 3rd-party Packages
import 'package:flutter/material.dart';

// Local
import 'package:easy_tracker/utils/themes.dart';

// use this for random pop ups that does NOTHING
// pass in a String you want to show

Future<void> showSimpleDialog(BuildContext ctx, String s) async {
  await showDialog(
    context: ctx,
    builder: (BuildContext ctx) {
      return SimpleDialog(msg: s);
    }
  );
}

class SimpleDialog extends StatelessWidget {
  final String? msg;

  // Constructor
  const SimpleDialog({
    Key? key,
    required String this.msg
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            Text(
              msg.toString(),
              style: bodyMedium,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Close',
                  style: bodySmall
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}