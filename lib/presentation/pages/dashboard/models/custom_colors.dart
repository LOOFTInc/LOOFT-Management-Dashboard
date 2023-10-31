import 'package:color_shader/color_shader.dart';
import 'package:flutter/material.dart';

enum CustomColors {
  green,
  blue,
  red,
  orange,
  purple,
  teal,
  pink,
  lime,
  indigo,
  cyan,
  amber,
  brown,
}

extension ColorsGeneartor on CustomColors {
  Color get color {
    switch (this) {
      case CustomColors.blue:
        return const Color(0xFF29ABE2);
      case CustomColors.red:
        return Colors.red;
      case CustomColors.orange:
        return const Color(0xFFF87517);
      case CustomColors.green:
        return const Color(0xFF30A32E);
      case CustomColors.purple:
        return const Color(0xFF9747FF);
      case CustomColors.teal:
        return Colors.teal;
      case CustomColors.pink:
        return Colors.pink;
      case CustomColors.lime:
        return Colors.lime;
      case CustomColors.indigo:
        return Colors.indigo;
      case CustomColors.cyan:
        return Colors.cyan;
      case CustomColors.amber:
        return Colors.amber;
      case CustomColors.brown:
        return Colors.brown;
    }
  }

  Color get lightModeBackgroundColor {
    return Shader(color.value, shades: 16).lightPalette().last;
  }

  Color get darkModeBackgroundColor {
    return Shader(color.value, shades: 16).darkPalette().last;
  }
}
