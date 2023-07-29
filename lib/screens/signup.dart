// 3rd-party Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Local
import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/widgets/simple_dialog.dart';

// Sign Up Page
// on error, show pop up, do nothing
// on successful sign up, return back to WelcomePage by welcome.dart

// uses Navigator.pop to go back to WelcomePage

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  Future<bool> signUp(BuildContext ctx) async {
    String eml = emailController.text.trim();
    String psd = passwordController.text.trim();
    String confirmPsd = confirmController.text.trim();

    // protections
    if (eml.isEmpty) {
      await showSimpleDialog(ctx, "Please enter your Email.");
      return false;
    }
    if (psd.isEmpty) {
      await showSimpleDialog(ctx, "Please enter password.");
      return false;
    }
    if (psd != confirmPsd) {
      await showSimpleDialog(ctx, "Passwords do not match.");
      return false;
    }

    bool successful = false;
    showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return const Center(
          child: CircularProgressIndicator()
        );
      }
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: eml,
        password: psd
      );
      successful = true;
      if (ctx.mounted) {
        await showSimpleDialog(ctx, "Account Successfully Created.");
      }
      return true;
    } on FirebaseAuthException catch (e) {
      await showSimpleDialog(ctx, e.message.toString());
    }
    if (ctx.mounted) {Navigator.of(ctx).pop();}
    return successful;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Account",
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
                    "Create Account",
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
                        "Please create an account",
                        style: bodyMedium,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Already have an account?",
                            style: bodySmall,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                "/Login"
                              );
                            },
                            style: txtBtnTheme,
                            child: const Text(
                              "Sign In",
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
                      const SizedBox(height: 10),
                      SizedBox(
                        child: TextField(
                          controller: confirmController,
                          obscureText: true,
                          decoration: customInputDecoWithLabel("Confirm Password")
                        )
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    bool pop = await signUp(context);
                    if (pop && context.mounted) {
                      Navigator.of(context).popUntil(ModalRoute.withName("/"));
                    }
                  },
                  style: mainBtnTheme,
                  child: const Text(
                    'Sign Up',
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