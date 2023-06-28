import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    scaffoldBackgroundColor: const Color(0xFFD0DDD7),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 32,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  home: Home(),
));

class Home extends StatelessWidget {
  const Home({super.key});

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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(0.71, -0.71),
                  end: Alignment(-0.71, 0.71),
                  colors: [Color(0xFFB2D3C2), Color(0xFFEBEBEB)],
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: Text(
                      'Welcome!',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Text(
                      'to personal finance tracker',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 2,
                minimumSize: Size(200, 50),
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
