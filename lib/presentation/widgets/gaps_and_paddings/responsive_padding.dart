import 'package:flutter/material.dart';

import '../../../constants.dart';

class ResponsivePadding extends StatelessWidget {
  /// Responsive Padding widget that adds padding based on screen size
  const ResponsivePadding({
    super.key,
    required this.padding,
    this.mobilePadding,
    required this.child,
    this.mobileSize,
  });

  /// Padding
  final EdgeInsets padding;

  /// Padding for mobile Screens
  final EdgeInsets? mobilePadding;

  /// Child widget
  final Widget child;

  /// Size at which the mobile padding is applied
  final double? mobileSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).size.width < (mobileSize ?? K.mobileSize)
          ? mobilePadding ?? padding
          : padding,
      child: child,
    );
  }
}
