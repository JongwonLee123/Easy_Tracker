import 'package:flutter/material.dart';
import 'package:easy_tracker/screens/sub_pages/edit_page.dart';
import 'package:easy_tracker/screens/sub_pages/new_image.dart';
import 'package:easy_tracker/test/themes.dart';

class ProfileEditButton extends StatelessWidget {
  Widget build(BuildContext context) {
    final double fem = MediaQuery.of(context).textScaleFactor;
    final double ffem = 1.0;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300 * fem),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfileImagePage()),
            );
          },
          style: btnWhiteTheme, // Apply the custom button theme here
          child: Padding(
            padding: EdgeInsets.all(12 * fem),
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
