// 3rd-party Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// Local
import 'package:easy_tracker/utils/app_user.dart';
import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/widgets/simple_dialog.dart';

// Login Page
// on error, show pop up, do nothing
// on successful login, proceed to MainPage by main_page.dart

// uses Navigator.pushReplacementNamed to prevent
// back button from navigating back to this page

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<User?> signIn(BuildContext ctx) async {
    showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return const Center(
            child: CircularProgressIndicator()
        );
      }
    );

    User? user;
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential uC = await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
      );
      user = uC.user;
      if (user != null) {
        DatabaseReference ref = FirebaseDatabase.instance.ref("users/${user.uid}");
        final snapshot = await ref.get();
        if (!(snapshot.exists)) {
          await ref.set({
            "name": user.displayName,
            "email": user.email
          });
        }
        if (ctx.mounted) {
          Navigator.of(ctx).pushReplacementNamed("/Main");
        }
      }
    } on FirebaseAuthException catch (e) {
      await showSimpleDialog(ctx, e.message.toString());
    }

    if (ctx.mounted) {Navigator.of(ctx).pop();}
    return user;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign In",
          style: bodyMedium,
        ),
        backgroundColor: fgWhite,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          color: Colors.black,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Sign In",
                style: bodyLarge,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Please sign in to continue",
                style: bodyMedium,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: fgWhite,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                shadows: const [generalShadow],
              ),
              child: Column(
                children: [
                  SizedBox(
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                      ),
                    )
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                      ),
                    )
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final user = await signIn(context);
                if (user != null && context.mounted) {
                  AppUser u = AppUser(
                    user.uid.toString(),
                    user.displayName.toString(),
                    user.email.toString()
                  );
                  Navigator.of(context).pushReplacementNamed(
                    "/Main",
                    arguments: u
                  );
                }
              },
              style: mainBtnTheme,
              child: const Text(
                'Sign In',
                textAlign: TextAlign.center,
                style: bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}