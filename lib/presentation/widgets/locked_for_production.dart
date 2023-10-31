import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class LockedForProduction extends StatelessWidget {
  /// Locks a screen for production
  const LockedForProduction({
    super.key,
    required this.child,
  });

  /// The child widget
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      return child;
    }

    return Stack(
      children: [
        IgnorePointer(child: child),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomSvg(
                  svgPath: 'assets/icons/lock.svg',
                  size: 100,
                ),
                Gap28(),
                CustomText(
                  'This screen is under development.\nIt will be unlocked when its operational.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
