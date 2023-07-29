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
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
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
                            "Username",
                            style: bodyMedium,
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
                                Text(
                                  name,
                                  style: usernameTextStyle,
                                ),
                              IconButton(
                                onPressed: () {
                                  // NOTHING
                                },
                                icon: const Icon(Icons.edit_outlined)
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              )
            )
          );
        }
      }
    );
  }
}