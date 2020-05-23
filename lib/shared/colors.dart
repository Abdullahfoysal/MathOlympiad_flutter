import 'package:flutter/material.dart';

List<Color> userSolvingStatusColor = [
  Colors.green.withOpacity(0.5), //solved
  Colors.red.withOpacity(0.5), //wrong submit
  Colors.deepOrangeAccent.withOpacity(0.5), //last chance to solve
  Colors.purple.withOpacity(0.5), //notallowed to solve
  Colors.blue.withOpacity(0.5), //not touch
];

Color appBarColor = HexColor("d61e59");
Color bottomNavButtonColor = HexColor("fd3c4f");
Color bottomNavBottomCenterColor = HexColor("fb643d");
Color bottomNavTopCenterColor = HexColor("ff0f63");

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
