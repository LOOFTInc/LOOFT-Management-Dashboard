import 'dart:math';

import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

import '../../../widgets/custom_svg.dart';

class CustomBackButton extends StatelessWidget {
  /// Custom Back Button Widget
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.rotate(
            angle: -pi,
            child: const CustomSvg(svgPath: 'assets/icons/chevron_right.svg'),
          ),
          const SizedBox(width: 5),
          const CustomText('Go Back', selectable: false),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
