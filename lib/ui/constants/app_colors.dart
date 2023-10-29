import 'package:flutter/material.dart';

class AppColors {
  static const transparent = Colors.transparent;
  // Main
  static const black = Color.fromRGBO(15, 8, 0, 1);
  static const white = Colors.white;
  static const red = Color.fromRGBO(220, 0, 0, 1);
  static const green = Color.fromRGBO(0, 180, 0, 1);

  static const darkGrey = Color.fromRGBO(49, 49, 49, 1);
  static const hintColor = Color.fromRGBO(126, 124, 124, 1);
  static const hintColor2 = Color.fromRGBO(165, 165, 165, 1);
  static const darkPink = Color.fromRGBO(255, 129, 174, 1);
  static const pink = Color.fromRGBO(254, 209, 243, 1);
  static const lightPink = Color.fromRGBO(250, 208, 201, 1);
  static const lightGrey = Color.fromRGBO(196, 196, 196, 1);
  static const veryLightGrey = Color.fromRGBO(236, 236, 236, 1);
  static const blue = Color.fromRGBO(33, 161, 201, 1);

  static const boxGradient = LinearGradient(
    colors: [pink, lightPink],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.5, 1],
  );

  static final homeBoxGradient = LinearGradient(
    colors: [darkGrey, pink.withOpacity(0.5)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: const [0.2, 1],
  );
}
