import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/status_widget.dart';
import 'package:responsive_ui/responsive_ui.dart';

class OverviewStatusWidget extends StatelessWidget {
  /// Widget to show the status on the overview page
  const OverviewStatusWidget({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.backgroundColor,
  });

  /// Title of the status
  final String title;

  /// Value of the status
  final double value;

  /// Percentage of the status
  final double percentage;

  /// Background color of the status container
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Div(
      divison: const Division(colXS: 12, colM: 6, colL: 3),
      child: StatusWidget(
        height: 117,
        width: 202,
        title: title,
        value: value,
        percentage: percentage,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
