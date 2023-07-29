// 3rd-party Packages
import 'package:flutter/material.dart';

// Local
import 'package:easy_tracker/utils/app_user.dart';
import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/widgets/profile_widget.dart';


class ProfilePage extends StatefulWidget {
  final AppUser appUser;
  const ProfilePage({Key? key, required this.appUser}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Page",
          style: bodyLarge,
        ),
        backgroundColor: fgWhite,
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       ProfileWidget(
      //         email: widget.appUser.email,
      //         name: widget.appUser.name,
      //         appUser: widget.appUser, // Pass the appUser instance to the ProfileWidget
      //         onUpdateName: (newName) {
      //           setState(() {
      //             widget.appUser.name = newName; // Update the name in the appUser instance
      //           });
      //         },
      //       ),
      //       SizedBox(height: 20),
      //     ],
      //   ),
      // ),
    );
  }
}