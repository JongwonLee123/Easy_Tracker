import 'package:flutter/material.dart';
import 'package:easy_tracker/widgets/profile_image_widget.dart';
import 'package:easy_tracker/widgets/profile_edit_button_widget.dart';
import 'package:easy_tracker/widgets/profile_info_widget.dart';
import 'package:easy_tracker/widgets/delete_widget.dart';

class EntireProfile extends StatelessWidget {
  Widget build(BuildContext context) {
    final double fem = MediaQuery.of(context).textScaleFactor;
    final double ffem = 1.0;

    return Container(
      // mainbody2Uh (51:927)
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // profileBMb (45:580)
            padding: EdgeInsets.fromLTRB(95 * fem, 0 * fem, 95 * fem, 0 * fem),
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x3f000000),
                  offset: Offset(0 * fem, 0 * fem),
                  blurRadius: 2 * fem,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileIcon(),
                ProfileEditButton(),
              ],
            ),
          ),
          SizedBox(
            height: 20 * fem,
          ),
          ProfileInfoWidget(),
          SizedBox(
            height: 20 * fem,
          ),
          DeleteButton(),
        ],
      ),
    );
  }
}
