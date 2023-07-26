// 3rd-party Packages
import 'package:flutter/material.dart';

// Local
import 'package:easy_tracker/utils/app_user.dart';
import 'package:easy_tracker/utils/themes.dart';

class ProfilePage extends StatefulWidget {
  final AppUser appUser;
  const ProfilePage({
    Key? key,
    required this.appUser
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Profile Page",
          style: bodyLarge,
        )
      )
    );
  }
}