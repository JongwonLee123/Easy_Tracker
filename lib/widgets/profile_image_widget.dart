import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  Widget build(BuildContext context) {
    final double fem = MediaQuery.of(context).textScaleFactor;
    final double ffem = 1.0;
    
    return Container(
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 10 * fem),
      width: 200 * fem,
      height: 200 * fem,
      child: Image(
        image: AssetImage('assets/profile.jpg'),
        width: 200 * fem,
        height: 200 * fem,
      ),
    );
  }
}
