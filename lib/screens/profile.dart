// 3rd-party Packages
import 'package:flutter/material.dart';

// Local
import 'package:easy_tracker/utils/app_user.dart';

import 'package:easy_tracker/widgets/profile_widget.dart';

import 'dart:developer';

class ProfilePage extends StatefulWidget {
  final AppUser appUser;
  const ProfilePage({Key? key, required this.appUser}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    log('Username:${widget.appUser.name}asd');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ProfileWidget(
                email: widget.appUser.email,
                name: widget.appUser.name,
                appUser: widget.appUser,
              ),
            ),
          ],
        ),
      ),
    );
  }
}