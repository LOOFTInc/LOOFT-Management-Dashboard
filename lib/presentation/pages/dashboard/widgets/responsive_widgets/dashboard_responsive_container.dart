import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/widgets/custom_container.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/responsive_padding.dart';

class DashboardResponsiveContainer extends StatefulWidget {
  /// A responsive container for the dashboard
  /// Changes padding based on screen size
  const DashboardResponsiveContainer({
    super.key,
    required this.child,
    this.scrollable = false,
    this.desktopPadding,
    this.mobilePadding,
  });

  /// The child widget
  final Widget child;

  /// Is the container scrollable
  final bool scrollable;

  /// Padding for desktop Screen
  final EdgeInsets? desktopPadding;

  /// Padding for Mobile Screen
  final EdgeInsets? mobilePadding;

  @override
  State<DashboardResponsiveContainer> createState() =>
      _DashboardResponsiveContainerState();
}

class _DashboardResponsiveContainerState
    extends State<DashboardResponsiveContainer> {
  late final Widget child = ResponsivePadding(
    padding: widget.desktopPadding ?? const EdgeInsets.all(28),
    mobilePadding: widget.mobilePadding ?? const EdgeInsets.all(16),
    child: widget.child,
  );

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: double.infinity,
      child: widget.scrollable
          ? SingleChildScrollView(
              child: child,
            )
          : child,
    );
  }
}
