import 'package:flutter/material.dart';

class LeftBarGap extends StatelessWidget {
  /// A gap widget for the left side bar - gap is 4px horizontally
  const LeftBarGap({
    super.key,
    this.isVertical = false,
  });

  /// Whether the gap is horizontal or vertical
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isVertical ? 0 : 4,
      height: isVertical ? 4 : 0,
    );
  }
}
