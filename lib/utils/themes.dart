// 3rd-party Packages
import 'package:flutter/material.dart';

// DESIGNS, THEMES, DECORATION, TEXT, ETC.

const bgColor = Color(0xFFD0DDD7);

// everything directly on the background
// will use this.
final fgWhiteTransparent = const Color(0xFFF9FFFC).withOpacity(0.8);
const fgWhite = Color(0xFFF9FFFC);

// for buttons and interactive objects
final btnWhite = const Color(0xFFF9FFFC).withOpacity(0.9);

const mainGradient = LinearGradient(
  begin: Alignment(0.71, -0.71),
  end: Alignment(-0.71, 0.71),
  colors: [Color(0xFFB2D3C2), Color(0xFFEBEBEB)],
);

// ===== ===== ===== ===== =====

const dividerTheme = DividerThemeData(
  space: 20,
  thickness: 2,
);

// ===== ===== ===== ===== =====

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
  foregroundColor: Colors.black12,
  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
);

// ===== ===== ===== ===== =====

InputDecoration customInputDecoWithLabel(String s) {
  return InputDecoration(
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: bgColor,
        width: 3
      )
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black12,
        width: 1
      )
    ),
    labelText: s,
    labelStyle: bodySmallFaded,
    floatingLabelStyle: bodySmallGreen,
  );
}

InputDecoration customInputDecoWithHint(String s) {
  return InputDecoration(
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: bgColor,
        width: 3
      )
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black12,
        width: 1
      )
    ),
    hintText: s,
    hintStyle: bodySmallFaded,
  );
}

// ===== ===== ===== ===== =====

// when Hero widget is making transition animations,
// the inner widget will be "mid-flight" which is outside
// of scaffolds which will make yellow underlines appear
// Use this in Hero widgets to prevent that behavior
Widget flightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return DefaultTextStyle(
    style: DefaultTextStyle.of(toHeroContext).style,
    child: toHeroContext.widget,
  );
}

// ===== ===== ===== ===== =====

const generalShadow = BoxShadow(
  color: Color(0x3F000000),
  blurRadius: 4,
  offset: Offset(0, 0),
  spreadRadius: 0,
);

// ===== ===== ===== ===== =====

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
const bodySmallFaded = TextStyle(
  color: Colors.black54,
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