import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/models/custom_colors.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class ColoredTextContainer extends StatelessWidget {
  /// Container with colored text and light colored background
  const ColoredTextContainer({
    super.key,
    required this.textColor,
    required this.text,
    this.textStyle = const TextStyle(),
  });

  /// Text to display
  final String text;

  /// Text Color
  final CustomColors textColor;

  /// Text Style
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: state.themeMode == ThemeMode.dark
                ? textColor.darkModeBackgroundColor
                : textColor.lightModeBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          child: CustomText(
            text,
            staticColor: textColor.color,
            style: textStyle.copyWith(fontSize: textStyle.fontSize ?? 12),
          ),
        );
      },
    );
  }
}
