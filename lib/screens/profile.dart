// Debug
import 'package:easy_tracker/widgets/simple_dialog.dart';

// 3rd-party Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// Local
import 'package:easy_tracker/utils/app_user.dart';
import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/widgets/confirm_logout_dialog.dart';
import 'package:easy_tracker/widgets/username_edit_dialog.dart';

class ProfilePage extends StatefulWidget {
  final AppUser appUser;
  const ProfilePage({Key? key, required this.appUser}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Future<void> prepareData() async {
    await widget.appUser.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: prepareData(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(
            child: Text(
              "Error: ${data.error}",
              style: bodyMedium,
            ));
        } else if (data.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: fgWhite,
            )
          );
        } else {
          String name = "";
          if (widget.appUser.name.toString().isNotEmpty) {
            name = widget.appUser.name.toString();
          }
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          gradient: mainGradient,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          shadows: const [generalShadow],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "USERNAME",
                              style: bodySmallFaded,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (name.isEmpty)
                                  Text(
                                    "Not set",
                                    style: usernameTextStyleFaded,
                                  ),
                                if (name.isNotEmpty)
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width - 120,
                                    child: Text(
                                      name,
                                      style: usernameTextStyle,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                                  ),
                                IconButton(
                                  onPressed: () async {
                                    String? newName = await showUsernameEditDialog(context);
                                    if (newName == null) {
                                      return;
                                    }
                                    DatabaseReference ref = FirebaseDatabase.instance.ref("users/${widget.appUser.uid}");
                                    if (newName == "") {
                                      widget.appUser.name = "";
                                      await ref.child("username").set(null);
                                    } else {
                                      await ref.child("username").set(newName);
                                    }
                                    setState(() {
                                      widget.appUser.loadData();
                                    });
                                  },
                                  icon: const Icon(Icons.edit_outlined)
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          color: fgWhiteTransparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          shadows: const [generalShadow],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "EMAIL",
                              style: bodySmallFaded,
                            ),
                            Text(
                              widget.appUser.email,
                              style: bodyMedium,
                            ),
                          ]
                        )
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await showSimpleDialog(context, "Nah");
                                },
                                style: btnWhiteTheme,
                                child: const Text(
                                  "Manage",
                                  style: bodyMedium,
                                )
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async {
                                  bool shouldLogout = await showConfirmLogoutDialog(context);
                                  if (shouldLogout && context.mounted) {
                                    Navigator.of(context).popUntil(ModalRoute.withName("/"));
                                    await FirebaseAuth.instance.signOut();
                                  }
                                },
                                style: btnWhiteTheme,
                                child: const Text(
                                  "Logout",
                                  style: bodyMedium,
                                )
                              ),
                            ),
                          ],
                        )
                      )
                    ],
                  ),
                )
              ),
            )
          );
        }
      }
    );
  }
}