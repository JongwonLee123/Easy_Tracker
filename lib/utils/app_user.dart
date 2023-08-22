// AppUser Object instance will be created by LoginPage
// this will exist throughout the app
// as long as the user does not Sign Out.

import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  String uid;
  String email;
  String? name = "";

  AppUser(this.uid, this.email);

  void loadData() {
    User u = FirebaseAuth.instance.currentUser!;
    if (u.displayName != null) {
      name = u.displayName;
    }
    email = u.email as String;
  }
}