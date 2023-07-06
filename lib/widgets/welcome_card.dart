import 'package:flutter/material.dart';
import 'package:easy_tracker/utils/themes.dart';

// Card on the welcome screen.
// says "Welcome! to personal Finance Tracker"

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        gradient: mainGradient,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome!',
            style: bodyLarge,
          ),
          SizedBox(height: 20),
          Text(
            'to personal finance tracker',
            style: bodySmall,
          ),
        ],
      ),
    );
  }
}