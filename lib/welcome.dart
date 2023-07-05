import 'package:flutter/material.dart';
import 'package:easy_tracker/screens/main_page.dart';
import 'package:easy_tracker/widgets/welcome_card.dart';

// upon pressing start button, it will navigate to screens/main_page.dart

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const WelcomeCard(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage())
                );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 2,
                  minimumSize: const Size(200, 50),
                  backgroundColor: Colors.white.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  )
              ),
              child: Text(
                'Start',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
