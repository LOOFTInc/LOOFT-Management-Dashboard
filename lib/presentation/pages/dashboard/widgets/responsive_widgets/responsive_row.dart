import 'package:flutter/material.dart';

import '../../../../widgets/gaps_and_paddings/gap_28.dart';

class ResponsiveRow extends StatelessWidget {
  /// Widget to show a row that is responsive based on the screen size
  /// [leftWidget] is the widget to show on the left
  /// [rightWidget] is the widget to show on the right
  const ResponsiveRow({
    super.key,
    required this.leftWidget,
    required this.rightWidget,
    required this.breakWidth,
    this.reverse = false,
    this.horizontalGapWidget,
    this.verticalGapWidget,
    this.rowMainAxisSize,
    this.rowMainAxisAlignment,
    this.columnCrossAxisAlignment,
    this.leftExpanded = false,
    this.rightExpanded = false,
    this.rowCrossAxisAlignment,
  });

  /// Widget to show on the left
  final Widget leftWidget;

  /// Widget to show on the right
  final Widget rightWidget;

  /// Width to break the row
  final double breakWidth;

  /// Whether to reverse the order of the widgets for Vertical View
  final bool reverse;

  /// Widget to show as a gap between the widgets in horizontal view
  final Widget? horizontalGapWidget;

  /// Widget to show as a gap between the widgets in vertical view
  final Widget? verticalGapWidget;

  /// Main axis size for the row
  final MainAxisSize? rowMainAxisSize;

  /// Main axis alignment for the row
  final MainAxisAlignment? rowMainAxisAlignment;

  /// Cross axis alignment for the column
  final CrossAxisAlignment? columnCrossAxisAlignment;

  /// Whether the left widget in row is expanded
  final bool leftExpanded;

  /// Whether the right widget in row is expanded
  final bool rightExpanded;

  /// Cross axis alignment for the row
  final CrossAxisAlignment? rowCrossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < breakWidth) {
      return Column(
        crossAxisAlignment:
            columnCrossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: reverse ? rightWidget : leftWidget,
          ),
          verticalGapWidget ?? const Gap28(),
          SizedBox(
            width: double.infinity,
            child: reverse ? leftWidget : rightWidget,
          ),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: rowCrossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisSize: rowMainAxisSize ?? MainAxisSize.min,
        mainAxisAlignment: rowMainAxisAlignment ?? MainAxisAlignment.center,
        children: [
          leftExpanded ? Expanded(child: leftWidget) : leftWidget,
          horizontalGapWidget ?? const Gap28(isHorizontal: true),
          rightExpanded ? Expanded(child: rightWidget) : rightWidget,
        ],
      );
    }
  }
}
