import 'package:flutter/material.dart';
import 'package:easy_tracker/widgets/net_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NetCard(
              income: 2440,
              expense: 385,
            ),
          ],
        )
      )
    );
  }
}
