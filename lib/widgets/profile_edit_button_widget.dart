import 'package:flutter/material.dart';

class ProfileEditButton extends StatelessWidget {
  Widget build(BuildContext context) {
    final double fem = MediaQuery.of(context).textScaleFactor;
    final double ffem = 1.0;

    return Container(
      margin: EdgeInsets.fromLTRB(39.5 * fem, 0 * fem, 39.5 * fem, 0 * fem),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Container(
          width: double.infinity,
          height: 45 * fem,
          decoration: BoxDecoration(
            color: Color(0x99ffffff),
            borderRadius: BorderRadius.circular(8 * fem),
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
              'Edit Profile',
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
      ),
    );
  }
}
