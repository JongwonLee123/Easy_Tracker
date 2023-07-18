import 'package:flutter/material.dart';

class ProfileInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double fem = MediaQuery.of(context).textScaleFactor;
    final double ffem = 1.0;

    return Container(
      padding: EdgeInsets.fromLTRB(10 * fem, 10 * fem, 10 * fem, 10 * fem),
      width: double.infinity,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0 * fem, 2 * fem, 0 * fem, 2 * fem),
            width: double.infinity,
            height: 33 * fem,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 4.5 * fem, 126 * fem, 4.5 * fem),
                  width: 89 * fem,
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      'USERNAME:',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.25 * ffem / fem,
                        color: Color(0x99000000),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 10 * fem, 0 * fem),
                        child: Text(
                          'Someone',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 20 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.25 * ffem / fem,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20 * fem),
          Container(
            padding: EdgeInsets.fromLTRB(0 * fem, 2 * fem, 0 * fem, 2 * fem),
            width: double.infinity,
            height: 33 * fem,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 4.5 * fem, 105 * fem, 4.5 * fem),
                  width: 49 * fem,
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      'EMAIL:',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.25 * ffem / fem,
                        color: Color(0x99000000),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 10 * fem, 0 * fem),
                        child: Text(
                          '*****@gmail.com',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 20 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.25 * ffem / fem,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20 * fem),
          Container(
            padding: EdgeInsets.fromLTRB(0 * fem, 2 * fem, 0 * fem, 2 * fem),
            width: double.infinity,
            height: 33 * fem,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 4.5 * fem, 162 * fem, 4.5 * fem),
                  width: 58 * fem,
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      'PHONE:',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.25 * ffem / fem,
                        color: Color(0x99000000),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 10 * fem, 0 * fem),
                        child: Text(
                          '******5566',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 20 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.25 * ffem / fem,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20 * fem),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: Container(
              width: 188 * fem,
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
                  'Change Password',
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
        ],
      ),
    );
  }
}
