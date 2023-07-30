import 'package:flutter/material.dart';

class EmailWidget extends StatelessWidget {
  final String email;

  const EmailWidget({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Email: $email",
      style: TextStyle(fontSize: 16),
    );
  }
}
