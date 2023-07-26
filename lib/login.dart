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
    String eml = emailController.text.trim();
    String psd = passwordController.text.trim();
    User? user;

    // protections
    if (eml.isEmpty) {
      await showSimpleDialog(ctx, "Please enter your Email.");
      return user;
    }
    if (psd.isEmpty) {
      await showSimpleDialog(ctx, "Please enter password.");
      return user;
    }

    showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return const Center(child: CircularProgressIndicator());
      }
    );

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential uC = await auth.signInWithEmailAndPassword(
        email: eml,
        password: psd
      );
      user = uC.user;
      if (user != null) {
        DatabaseReference ref =
          FirebaseDatabase.instance.ref("users/${user.uid}");
        final snapshot = await ref.get();
        if (!(snapshot.exists)) {
          await ref.set({"name": user.displayName, "email": user.email});
        }
        if (ctx.mounted) {
          Navigator.of(ctx).pushReplacementNamed("/Main");
        }
      }
    } on FirebaseAuthException catch (e) {
      await showSimpleDialog(ctx, e.message.toString());
    }

    if (ctx.mounted) {
      Navigator.of(ctx).pop();
    }
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
      body: Center(
        child: SingleChildScrollView(
          child: Container(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Please sign in to continue",
                        style: bodyMedium,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: bodySmall,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                "/Signup"
                              );
                            },
                            style: txtBtnTheme,
                            child: const Text(
                              "Create One",
                              style: bodySmallGreen,
                            )
                          ),
                        ],
                      )
                    ],
                  )
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: fgWhiteTransparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    shadows: const [generalShadow],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        child: TextField(
                          controller: emailController,
                          decoration: customInputDecoWithLabel("Email")
                        )
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: customInputDecoWithLabel("Password")
                        )
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {},
                  style: txtBtnTheme,
                  child: const Text(
                    "Forgot Password?",
                    style: bodySmallGreen,
                  )
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final user = await signIn(context);
                    if (user != null && context.mounted) {
                      AppUser u = AppUser(
                        user.uid.toString(),
                        user.displayName.toString(), user.email.toString()
                      );
                      Navigator.of(context).pushReplacementNamed("/Main", arguments: u);
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
        ),
      )
    );
  }
}
