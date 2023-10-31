import 'package:flutter/material.dart';

import '../../constants.dart';

class ScrollableWidget extends StatelessWidget {
  /// Makes a Widget Scrollable based on max Screen Width or Height
  const ScrollableWidget({
    Key? key,
    this.minSize,
    this.widgetSize,
    required this.child,
    required this.scrollDirection,
  }) : super(key: key);

  /// Minimum Screen Size after which the Widget will become scrollable
  ///
  /// Default is 1366
  final double? minSize;

  /// Size of the Widget when it becomes scrollable
  ///
  /// Defaults to minimum Screen Size
  final double? widgetSize;

  /// Widget to show inside the Scrollable Widget
  final Widget child;

  /// Scroll Direction - Horizontal or Vertical
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    const double defaultMinWidth = K.maxScreenWidth;

    return (scrollDirection == Axis.horizontal
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.height) <
            (minSize ?? defaultMinWidth)
        ? SingleChildScrollView(
            scrollDirection: scrollDirection,
            child: SizedBox(
              width: scrollDirection == Axis.horizontal
                  ? (widgetSize ?? minSize ?? defaultMinWidth)
                  : null,
              height: scrollDirection == Axis.vertical
                  ? (widgetSize ?? minSize ?? defaultMinWidth)
                  : null,
              child: child,
            ),
          )
        : child;
  }
}
