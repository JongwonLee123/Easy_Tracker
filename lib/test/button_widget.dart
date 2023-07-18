import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  ButtonWidget({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate fem and ffem values based on screen size
    final fem = screenWidth * 0.02; // Adjust the multiplier as needed
    final ffem = screenHeight * 0.02; // Adjust the multiplier as needed

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        width: 56 * fem,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0x4c000000),
          borderRadius: BorderRadius.circular(4 * fem),
          boxShadow: [
            BoxShadow(
              color: Color(0x3f000000),
              offset: Offset(0 * fem, 0 * fem),
              blurRadius: 2 * fem,
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Edit',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20 * ffem,
              fontWeight: FontWeight.w500,
              height: 1.25 * ffem / fem,
              color: Color(0xff000000),
            ),
          ),
        ),
      ),
    );
  }
}