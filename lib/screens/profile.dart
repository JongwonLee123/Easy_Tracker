import 'package:flutter/material.dart';
import 'package:easy_tracker/widgets/profile_info_widget.dart';
import 'package:easy_tracker/widgets/profile_edit_button_widget.dart';
import 'package:easy_tracker/widgets/profile_image_widget.dart';
import 'package:easy_tracker/widgets/delete_widget.dart';
import 'package:easy_tracker/widgets/profile_entire_widget.dart';
import 'dart:io';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            ProfileIcon(),
            ProfileEditButton(),
            const SizedBox(height: 20.0),
            ProfileInfoWidget(),
            const SizedBox(height: 20.0),
            DeleteButton(),
            // EntireProfile(),
          ],
        ),
      ),
    );
  }
}
