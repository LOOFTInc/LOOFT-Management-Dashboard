import 'package:flutter/material.dart';

import '../../../logic/cubits/theme/theme_cubit.dart';

/// Enum to define the available Opacity styles for the Text Widget
enum OpacityColors {
  op5,
  op10,
  op20,
  op40,
  op50,
  op80,
  op100,
  rop5,
  rop10,
  rop20,
  rop40,
  rop50,
  rop80,
  rop100,
}

extension OpacityColorsExtension on OpacityColors {
  /// Returns the Color from the [opacity] based on Theme [state]
  Color getColorFromThemeState(ThemeState state) {
    switch (this) {
      case OpacityColors.op5:
        return state.opacity5;
      case OpacityColors.op10:
        return state.opacity10;
      case OpacityColors.op20:
        return state.opacity20;
      case OpacityColors.op40:
        return state.opacity40;
      case OpacityColors.op50:
        return state.opacity50;
      case OpacityColors.op80:
        return state.opacity80;
      case OpacityColors.op100:
        return state.opacity100;
      case OpacityColors.rop5:
        return state.reverseOpacity5;
      case OpacityColors.rop10:
        return state.reverseOpacity10;
      case OpacityColors.rop20:
        return state.reverseOpacity20;
      case OpacityColors.rop40:
        return state.reverseOpacity40;
      case OpacityColors.rop50:
        return state.reverseOpacity50;
      case OpacityColors.rop80:
        return state.reverseOpacity80;
      case OpacityColors.rop100:
        return state.reverseOpacity100;
    }
  }
}
