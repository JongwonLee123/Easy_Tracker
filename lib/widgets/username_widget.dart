import 'package:easy_tracker/utils/themes.dart';
import 'package:flutter/material.dart';

class UsernameWidget extends StatelessWidget {
  final String? name;
  final Function() onEdit;

  const UsernameWidget({
    Key? key,
    this.name,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Name: ${name ?? 'N/A'}",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          style: btnGreyTheme,
          onPressed: onEdit,
          child: Text('Edit'),
        ),
      ],
    );
  }
}
