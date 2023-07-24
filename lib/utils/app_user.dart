// AppUser Object instance will be created by LoginPage
// this will exist throughout the app
// as long as the user does not Sign Out.

class AppUser {
  String uid;
  String? name;
  String email;

  AppUser(this.uid, this.name, this.email);
}