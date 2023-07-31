// AppUser Object instance will be created by LoginPage
// this will exist throughout the app
// as long as the user does not Sign Out.

import 'package:firebase_database/firebase_database.dart';

class AppUser {
  String uid;
  String email;
  String? name;

  AppUser(this.uid, this.email);

  Future<void> loadData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
    final snapE = await ref.child("email").get();
    if (snapE.exists) {
      email = snapE.value.toString();
    }

    final snapN = await ref.child("username").get();
    if (snapN.exists) {
      name = snapN.value.toString();
    }
  }

  Future<void> updateData({String? newEmail, String? newName}) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
    if (newEmail != null) {
      await ref.child("email").set(newEmail);
      email = newEmail;
    }

    if (newName != null) {
      await ref.child("username").set(newName);
      name = newName;
    }
  }

  // Add a method to refresh user data
  Future<void> refreshData() async {
    await loadData();
  }
}