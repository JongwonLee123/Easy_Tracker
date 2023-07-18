import 'package:flutter/material.dart';
import 'package:easy_tracker/widgets/profile_info_widget.dart';
import 'package:easy_tracker/widgets/profile_edit_button_widget.dart';
import 'package:easy_tracker/widgets/profile_image_widget.dart';
import 'package:easy_tracker/widgets/delete_widget.dart';
import 'dart:io';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileIcon(),
            ProfileEditButton(),
            ProfileInfoWidget(),
            DeleteButton(),
          ],
        ),
      ),
    );
  }
}
