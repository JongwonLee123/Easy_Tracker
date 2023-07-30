import 'package:easy_tracker/utils/themes.dart';
import 'package:flutter/material.dart';

class PasswordWidget extends StatelessWidget {
  final Function() onChangePassword;

  const PasswordWidget({Key? key, required this.onChangePassword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: btnGreyTheme,
      onPressed: onChangePassword,
      child: Text("Change Password"),
    );
  }
}
