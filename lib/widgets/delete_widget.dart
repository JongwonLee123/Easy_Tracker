import 'package:flutter/material.dart';
import 'package:easy_tracker/test/themes.dart';

class DeleteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double fem = MediaQuery.of(context).textScaleFactor;
    final double ffem = 1.0;

    return Container(
      width: double.infinity,
      height: 45 * fem,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 150 * fem, 0 * fem),
            child: Theme(
              data: Theme.of(context).copyWith(
                textButtonTheme: TextButtonThemeData(style: btnWhiteTheme),
              ),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: Container(
                  width: 93 * fem,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0x99ffffff),
                    borderRadius: BorderRadius.circular(8 * fem),
                    boxShadow: [
                      generalShadow,
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Log out',
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
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              textButtonTheme: TextButtonThemeData(style: btnRedTheme),
            ),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Container(
                width: 147 * fem,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xd8c10000),
                  borderRadius: BorderRadius.circular(8 * fem),
                  boxShadow: [
                    generalShadow,
                  ],
                ),
                child: Center(
                  child: Text(
                    'Delete Profile',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 20 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.25 * ffem / fem,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
