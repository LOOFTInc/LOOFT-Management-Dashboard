import 'package:flutter/material.dart';

class ClickCursorOnHover extends StatelessWidget {
  /// A widget that changes the cursor to a click cursor on hover
  const ClickCursorOnHover({super.key, required this.child});

  /// The child widget
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: child,
    );
  }
}
