import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/responsive_padding.dart';

class DashboardResponsiveHorizontalPadding extends StatelessWidget {
  /// A responsive horizontal padding for the dashboard
  const DashboardResponsiveHorizontalPadding({
    super.key,
    required this.child,
  });

  /// The child widget
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding(
      padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
      mobilePadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: child,
    );
  }
}
