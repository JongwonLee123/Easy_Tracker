// 3rd-party Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Local
import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/widgets/simple_dialog.dart';

// Forgot Password Page

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}): super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();

  Future<bool> sendResetEmail(BuildContext ctx) async {
    String eml = emailController.text.trim();
    if (eml.isEmpty) {
      await showSimpleDialog(
        ctx,
        "Please enter the email associated with your account."
      );
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
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: eml,
      );
      successful = true;
      if (ctx.mounted) {
        await showSimpleDialog(ctx, "Email was sent to this email address $eml.");
      }
    } on FirebaseAuthException catch (e) {
      await showSimpleDialog(ctx, e.message.toString());
    }

    if (ctx.mounted) {Navigator.of(ctx).pop();}
    return successful;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reset Password",
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
                    "Reset Password",
                    style: bodyLarge,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                    alignment: Alignment.centerLeft,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Please enter the email address associated "
                              "with your account, and we'll send a "
                              "password reset link to that email.\n"
                              "If you don't receive an email within "
                              "a few minutes, please check your "
                              "spam folder, just in case.",
                          style: bodySmall,
                        ),
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
                          decoration: customInputDecoWithLabel("Email"),
                        )
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    bool pop = await sendResetEmail(context);
                    if (pop && context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  style: mainBtnTheme,
                  child: const Text(
                    'Send Email',
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