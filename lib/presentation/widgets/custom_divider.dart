import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';

class CustomDivider extends StatelessWidget {
  /// Custom Divider
  const CustomDivider({
    super.key,
    this.opacityColor,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
  });

  /// Opacity color of the divider
  final OpacityColors? opacityColor;

  /// Height of the divider
  final double? height;

  /// Thickness of the divider
  final double? thickness;

  /// Starting Indent of the divider
  final double? indent;

  /// Ending Indent of the divider
  final double? endIndent;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Divider(
          color: opacityColor?.getColorFromThemeState(state),
          height: height,
          thickness: thickness,
          indent: indent,
          endIndent: endIndent,
        );
      },
    );
  }
}
