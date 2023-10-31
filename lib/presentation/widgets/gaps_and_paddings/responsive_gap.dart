import 'package:flutter/material.dart';

import '../../../constants.dart';

class ResponsiveGap extends StatelessWidget {
  /// A gap widget - gap is 16px vertically by default
  /// can be set to be horizontal
  const ResponsiveGap({
    super.key,
    this.isHorizontal = false,
    required this.mobileGap,
    required this.desktopGap,
  });

  /// Whether the gap is horizontal or vertical
  final bool isHorizontal;

  /// The gap for mobile
  final double mobileGap;

  /// The gap for desktop
  final double desktopGap;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < K.mobileSize;

    return SizedBox(
      height: isHorizontal
          ? 0
          : isMobile
              ? mobileGap
              : desktopGap,
      width: isHorizontal
          ? isMobile
              ? mobileGap
              : desktopGap
          : 0,
    );
  }
}
