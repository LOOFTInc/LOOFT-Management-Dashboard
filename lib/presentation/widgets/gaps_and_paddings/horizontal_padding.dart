import 'package:flutter/material.dart';

import '../../../constants.dart';

class HorizontalPadding extends StatelessWidget {
  /// Adds Horizontal Padding to Screen Content
  const HorizontalPadding({
    Key? key,
    required this.child,
    this.padding,
    this.mobilePadding,
  }) : super(key: key);

  /// Widget to show in the Screen
  final Widget child;

  /// Horizontal Padding
  final double? padding;

  /// Mobile Padding
  final double? mobilePadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: (MediaQuery.of(context).size.width < K.mobileSize
                  ? mobilePadding
                  : padding) ??
              K.padding),
      child: Center(
        child: child,
      ),
    );
  }
}
