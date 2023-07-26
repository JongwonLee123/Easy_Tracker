// 3rd-party Packages
import 'package:flutter/material.dart';

// Local
import 'package:easy_tracker/utils/themes.dart';

void showBlankSnackBar(BuildContext ctx, String str) {
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      backgroundColor: fgWhiteTransparent,
      content: Text(
        str,
        style: bodyMedium,
      ),
    )
  );
}