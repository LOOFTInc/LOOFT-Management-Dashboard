import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';

import '../../../data/models/enums/opacity_colors.dart';

class CustomText extends StatelessWidget {
  /// Custom Text Widget with Theme Support.
  /// Will rebuild the text widget when the theme changes
  const CustomText(
    this.text, {
    super.key,
    this.selectable = true,
    this.style = const TextStyle(),
    this.opacity,
    this.textAlign,
    this.maxLines,
    this.staticColor,
    this.showTooltip = false,
  });

  /// Text to show in the
  final String text;

  /// Whether the text is selectable
  final bool selectable;

  /// Style of the Text
  final TextStyle style;

  /// Opacity of the Text
  final OpacityColors? opacity;

  /// Alignment of the Text
  final TextAlign? textAlign;

  /// Max Lines of the Text
  final int? maxLines;

  /// Static Color of the Text
  final Color? staticColor;

  /// Whether to show a tooltip on the text
  final bool showTooltip;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      buildWhen: (previous, current) => opacity != null,
      builder: (context, state) {
        Widget textWidget = Text(
          text,
          style: style.copyWith(
            color: staticColor ?? opacity?.getColorFromThemeState(state),
          ),
          textAlign: textAlign,
          maxLines: maxLines,
        );

        if (showTooltip) {
          textWidget = Tooltip(
            message: text,
            waitDuration: const Duration(milliseconds: 1500),
            child: textWidget,
          );
        }

        if (selectable) {
          return SelectionArea(
            child: textWidget,
          );
        }

        return textWidget;
      },
    );
  }
}
