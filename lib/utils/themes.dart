// 3rd-party Packages
import 'package:flutter/material.dart';

// DESIGNS, THEMES, DECORATION, TEXT, ETC.

const bgColor = Color(0xFFD0DDD7);

// cards, appBars, navBars,
// everything directly on the background
// will use this.
final fgWhite = Colors.white.withOpacity(0.7);

// for buttons and interactive objects
final btnWhite = Colors.white.withOpacity(0.9);

const dividerTheme = DividerThemeData(
  space: 20,
  thickness: 2,
);

final mainBtnTheme = ElevatedButton.styleFrom(
  elevation: 2,
  minimumSize: const Size(200, 50),
  backgroundColor: btnWhite,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25),
  )
);

final btnWhiteTheme = ElevatedButton.styleFrom(
  elevation: 2,
  backgroundColor: btnWhite,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  )
);
final btnGreenTheme = ElevatedButton.styleFrom(
  elevation: 2,
  backgroundColor: const Color(0xFF77CD70),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  )
);
final btnRedTheme = ElevatedButton.styleFrom(
  elevation: 2,
  backgroundColor: const Color(0xFFDD8080),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  )
);
final txtBtnTheme = TextButton.styleFrom(
  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
);

const generalShadow = BoxShadow(
  color: Color(0x3F000000),
  blurRadius: 4,
  offset: Offset(0, 0),
  spreadRadius: 0,
);

const mainGradient = LinearGradient(
  begin: Alignment(0.71, -0.71),
  end: Alignment(-0.71, 0.71),
  colors: [Color(0xFFB2D3C2), Color(0xFFEBEBEB)],
);

const bodyLarge = TextStyle(
  color: Colors.black,
  fontSize: 34,
  fontFamily: 'Quicksand',
  fontWeight: FontWeight.w800,
);
const bodyMedium = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontFamily: 'Quicksand',
  fontWeight: FontWeight.w800,
);
const bodySmall = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontFamily: 'Quicksand',
  fontWeight: FontWeight.w700,
);
const bodySmallGreen = TextStyle(
  color: Color(0xFF0EA800),
  fontSize: 16,
  fontFamily: 'Quicksand',
  fontWeight: FontWeight.w700,
);
const bodySmallRed = TextStyle(
  color: Color(0xFFDD3030),
  fontSize: 16,
  fontFamily: 'Quicksand',
  fontWeight: FontWeight.w700,
);
const bodyNumLarge = TextStyle(
  color: Colors.black,
  fontSize: 34,
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w800,
);
const bodyNumMedium = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w600,
);
const bodyNumSmall = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w600,
);