// 3rd-party Packages
import 'package:flutter/material.dart';

// Local
import 'package:easy_tracker/utils/themes.dart';
import 'package:easy_tracker/widgets/welcome_card.dart';

// upon pressing start button, it will navigate to screens/main_page.dart

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const WelcomeCard(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/Login");
                  },
                  style: mainBtnTheme,
                  child: const Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: bodyMedium,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/Signup");
                  },
                  style: mainBtnTheme,
                  child: const Text(
                    'Create Account',
                    textAlign: TextAlign.center,
                    style: bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
