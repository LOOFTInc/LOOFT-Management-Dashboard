import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

import '../../../data/models/enums/opacity_colors.dart';

class CustomTextButton extends StatefulWidget {
  /// A button with static colors for Dark Mode and Light Mode
  const CustomTextButton({
    super.key,
    this.onPressed,
    required this.text,
    this.textColor,
    this.backgroundColor,
    this.backgroundOpacityColor,
    this.textOpacityColor,
    this.child,
    this.fontSize,
  });

  /// The onPressed of the button
  final Function()? onPressed;

  /// The text of the button
  final String text;

  /// The color of the text
  final Color? textColor;

  /// The color of the button
  final Color? backgroundColor;

  /// Colors with opacity from Theme Cubit
  /// Will override Background Color
  final OpacityColors? backgroundOpacityColor;

  /// Colors with opacity from Theme Cubit
  /// Will override Text Color
  final OpacityColors? textOpacityColor;

  /// The child of the button
  final Widget? child;

  /// The font size of the button text
  final double? fontSize;

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        Color backgroundColor = widget.backgroundColor ?? K.primaryBlue;

        if (widget.backgroundOpacityColor != null) {
          backgroundColor =
              widget.backgroundOpacityColor!.getColorFromThemeState(state);
        }

        Color textColor = widget.textColor ?? state.reverseOpacity100;

        if (widget.textOpacityColor != null) {
          textColor = widget.textOpacityColor!.getColorFromThemeState(state);
        }

        return TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
              (_) => backgroundColor,
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
          ),
          onPressed: () async {
            if (widget.onPressed == null || loading) {
              return;
            }

            setState(() {
              loading = true;
            });
            await widget.onPressed!();
            setState(() {
              loading = false;
            });
          },
          child: loading
              ? SizedBox(
                  height: (widget.fontSize ?? 18) + 4,
                  width: (widget.fontSize ?? 18) + 4,
                  child: CircularProgressIndicator(
                    color: textColor,
                    strokeWidth: 3,
                  ),
                )
              : widget.child ??
                  CustomText(
                    widget.text,
                    selectable: false,
                    style: TextStyle(
                      color: textColor,
                      fontSize: widget.fontSize ?? 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
        );
      },
    );
  }
}
