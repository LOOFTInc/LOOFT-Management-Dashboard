import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';

import '../../logic/cubits/theme/theme_cubit.dart';

class CustomSvg extends StatelessWidget {
  /// Custom svg widget
  ///
  /// Changes color based on theme
  const CustomSvg({
    super.key,
    required this.svgPath,
    this.size,
    this.width,
    this.height,
    this.alignment,
    this.opacity,
  });

  /// Path to the svg file
  final String svgPath;

  /// Width and height of the svg
  final double? size;

  /// Width of the svg
  final double? width;

  /// Height of the svg
  final double? height;

  /// Alignment of the svg
  final AlignmentGeometry? alignment;

  /// Opacity colors
  final OpacityColors? opacity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return SvgPicture.asset(
          svgPath,
          colorFilter: ColorFilter.mode(
              opacity?.getColorFromThemeState(state) ?? state.opacity100,
              BlendMode.srcIn),
          width: width ?? size,
          height: height ?? size,
          alignment: alignment ?? Alignment.center,
        );
      },
    );
  }
}
