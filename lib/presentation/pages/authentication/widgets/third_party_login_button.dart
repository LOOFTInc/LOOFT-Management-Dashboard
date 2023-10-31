import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

import '../../../../constants.dart';

class ThirdPartyLoginButton extends StatelessWidget {
  /// Button to Login with Third Party Services
  const ThirdPartyLoginButton({
    super.key,
    required this.text,
    required this.svgPath,
    this.onPressed,
  });

  /// Text to show in the Button
  final String text;

  /// Path to the SVG Icon
  final String svgPath;

  /// Callback when the Button is pressed
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            ),
            side: MaterialStateProperty.all(
              BorderSide(
                color: state.opacity10,
                width: 1,
              ),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            backgroundColor:
                MaterialStateColor.resolveWith((states) => K.white5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(svgPath),
              const SizedBox(width: 8),
              CustomText(
                text,
                selectable: false,
              ),
            ],
          ),
        );
      },
    );
  }
}
