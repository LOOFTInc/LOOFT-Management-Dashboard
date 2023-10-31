import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/responsive_padding.dart';

class ResponsivePaddingForTabs extends StatelessWidget {
  /// A widget to display a responsive padding for the details tabs
  const ResponsivePaddingForTabs({
    super.key,
    required this.child,
    this.top = false,
  });

  /// Child widget to be displayed
  final Widget child;

  /// Whether the padding should be applied to the top
  final bool top;

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding(
      padding: EdgeInsets.fromLTRB(28, top ? 28 : 0, 28, 0),
      mobilePadding: EdgeInsets.fromLTRB(16, top ? 16 : 0, 16, 0),
      child: child,
    );
  }
}
