import 'package:easy_tracker/utils/themes.dart';
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
                    PageRouteBuilder(
                      pageBuilder: (context, ani, ani2) => const MainPage(),
                      transitionsBuilder: (context, ani, ani2, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;

                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: ani.drive(tween),
                          child: child,
                        );
                      },
                    )
                    //MaterialPageRoute(builder: (context) => const MainPage())
                );
              },
              style: mainBtnTheme,
              child: const Text(
                'Start',
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
