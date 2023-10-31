import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';

class CustomContainer extends StatelessWidget {
  /// Custom container widget
  const CustomContainer({
    super.key,
    this.staticBackgroundColor,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.border,
    this.borderRadius,
    this.child,
  });

  /// Static background color for the container
  final Color? staticBackgroundColor;

  /// Padding of the container
  final EdgeInsets? padding;

  /// Margin of the container
  final EdgeInsets? margin;

  /// Width of the container
  final double? width;

  /// Height of the container
  final double? height;

  /// Border of the container
  final BoxBorder? border;

  /// Border radius of the container
  final BorderRadius? borderRadius;

  /// Child widget
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          padding: padding,
          margin: margin,
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: staticBackgroundColor ??
                (state.themeMode == ThemeMode.light
                    ? K.cardsLightBackgroundColor
                    : K.white5),
            border: border,
            borderRadius: borderRadius ?? BorderRadius.circular(16),
          ),
          child: child,
        );
      },
    );
  }
}
