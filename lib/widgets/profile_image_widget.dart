import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  Widget build(BuildContext context) {
    final double fem = MediaQuery.of(context).textScaleFactor;
    final double ffem = 1.0;

    return Container(
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 10 * fem),
      width: 200 * fem,
      height: 200 * fem,
      child: ClipOval(
        child: Image(
          image: AssetImage('assets/new_profile_image.jpg'), // Replace with the new image asset path
          width: 200 * fem,
          height: 200 * fem,
          fit: BoxFit.cover, // Adjust the image inside the circle
        ),
      ),
    );
  }
}
