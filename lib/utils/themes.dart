import 'package:flutter/material.dart';

const bgColor = Color(0xFFD0DDD7);

// cards, appBars, navBars,
// everything directly on the background
// will use this.
const fgWhite = Colors.white70;

// for buttons and interactive objects
final btnWhite = Colors.white.withOpacity(0.9);

const mainGradient = LinearGradient(
  begin: Alignment(0.71, -0.71),
  end: Alignment(-0.71, 0.71),
  colors: [Color(0xFFB2D3C2), Color(0xFFEBEBEB)],
);

const bodyLarge = TextStyle(
  color: Colors.black,
  fontSize: 32,
  fontFamily: 'Quicksand',
  fontWeight: FontWeight.w900,
);
const bodyMedium = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontFamily: 'Quicksand',
  fontWeight: FontWeight.w600,
);
const bodySmall = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontFamily: 'Quicksand',
  fontWeight: FontWeight.w500,
);