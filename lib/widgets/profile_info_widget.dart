import 'package:flutter/material.dart';
import 'package:easy_tracker/screens/sub_pages/edit_page.dart';
import 'package:easy_tracker/test/themes.dart';

class ProfileInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double fem = MediaQuery.of(context).textScaleFactor;
    final double ffem = 1.0;

    return Container(
      padding: EdgeInsets.fromLTRB(10 * fem, 10 * fem, 10 * fem, 10 * fem),
      width: double.infinity,
      decoration: BoxDecoration(
        color: fgWhite,
        borderRadius: BorderRadius.circular(8 * fem),
        boxShadow: [
          BoxShadow(
            color: generalShadow.color,
            offset: generalShadow.offset,
            blurRadius: generalShadow.blurRadius * fem,
            spreadRadius: generalShadow.spreadRadius * fem,
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
                  width: 89 * fem,
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      'USERNAME:',
                      style: bodySmall.copyWith(color: Color(0x99000000)),
                    ),
                  ),
                ),
                SizedBox(width: 20 * fem), // Add a small spacing between the label and text
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          'Someone',
                          style: bodyMedium.copyWith(color: Color(0x99000000)),
                        ),
                      ),
                      Spacer(), // Add a spacer to push the "Someone" text to the right
                    ],
                  ),
                ),
                SizedBox(width: 20 * fem), // Add spacing between "Someone" and the "Edit" button
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(ProfileField.username),
                      ),
                    );
                  },
                  style: txtBtnTheme,
                  child: Container(
                    width: 56 * fem,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: btnGrey,
                      borderRadius: BorderRadius.circular(4 * fem),
                      boxShadow: [
                        BoxShadow(
                          color: generalShadow.color,
                          offset: generalShadow.offset,
                          blurRadius: generalShadow.blurRadius * fem,
                          spreadRadius: generalShadow.spreadRadius * fem,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Edit',
                        style: bodyMedium.copyWith(color: Color(0x99000000)),
                      ),
                    ),
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
                  margin: EdgeInsets.fromLTRB(0 * fem, 4.5 * fem, 105 * fem, 4.5 * fem),
                  width: 49 * fem,
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      'EMAIL:',
                      style: bodySmall.copyWith(color: Color(0x99000000)),
                    ),
                  ),
                ),
                SizedBox(width: 20 * fem), // Add a small spacing between the label and text
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          '*****@gmail.com',
                          style: bodyMedium.copyWith(color: Color(0x99000000)),
                        ),
                      ),
                      Spacer(), // Add a spacer to push the email text to the right
                    ],
                  ),
                ),
                SizedBox(width: 20 * fem), // Add spacing between email text and the "Edit" button
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(ProfileField.email),
                      ),
                    );
                  },
                  style: txtBtnTheme,
                  child: Container(
                    width: 56 * fem,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: btnGrey,
                      borderRadius: BorderRadius.circular(4 * fem),
                      boxShadow: [
                        BoxShadow(
                          color: generalShadow.color,
                          offset: generalShadow.offset,
                          blurRadius: generalShadow.blurRadius * fem,
                          spreadRadius: generalShadow.spreadRadius * fem,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Edit',
                        style: bodyMedium.copyWith(color: Color(0x99000000)),
                      ),
                    ),
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
                  margin: EdgeInsets.fromLTRB(0 * fem, 4.5 * fem, 162 * fem, 4.5 * fem),
                  width: 58 * fem,
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      'PHONE:',
                      style: bodySmall.copyWith(color: Color(0x99000000)),
                    ),
                  ),
                ),
                SizedBox(width: 20 * fem), // Add a small spacing between the label and text
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          '******5566',
                          style: bodyMedium.copyWith(color: Color(0x99000000)),
                        ),
                      ),
                      Spacer(), // Add a spacer to push the phone number text to the right
                    ],
                  ),
                ),
                SizedBox(width: 20 * fem), // Add spacing between the phone number text and the "Edit" button
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(ProfileField.phoneNumber),
                      ),
                    );
                  },
                  style: txtBtnTheme,
                  child: Container(
                    width: 56 * fem,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: btnGrey,
                      borderRadius: BorderRadius.circular(4 * fem),
                      boxShadow: [
                        BoxShadow(
                          color: generalShadow.color,
                          offset: generalShadow.offset,
                          blurRadius: generalShadow.blurRadius * fem,
                          spreadRadius: generalShadow.spreadRadius * fem,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Edit',
                        style: bodyMedium.copyWith(color: Color(0x99000000)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20 * fem),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditProfilePage(ProfileField.password)),
              );
            },
            style: btnWhiteTheme,
            child: Container(
              width: 188 * fem,
              height: 45 * fem,
              child: Center(
                child: Text(
                  'Change Password',
                  style: bodyMedium.copyWith(color: Color(0x99000000)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
