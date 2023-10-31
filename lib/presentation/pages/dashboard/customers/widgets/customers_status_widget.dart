import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/status_widget.dart';
import 'package:responsive_ui/responsive_ui.dart';

class CustomersStatusWidget extends StatelessWidget {
  /// Widget to show the status on the overview page
  const CustomersStatusWidget({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.backgroundColor,
    this.isMoney = false,
    required this.topRightSVGPath,
  });

  /// Title of the status
  final String title;

  /// Value of the status
  final double value;

  /// Percentage of the status
  final double percentage;

  /// Background color of the status container
  final Color backgroundColor;

  /// Whether the value is money or not
  final bool isMoney;

  /// SVG path of the picture to show in the top right corner
  final String topRightSVGPath;

  @override
  Widget build(BuildContext context) {
    return Div(
      divison: const Division(colXS: 4),
      child: StatusWidget(
        height: 120,
        title: title,
        value: value,
        percentage: percentage,
        backgroundColor: backgroundColor,
        isMoney: isMoney,
        topRightSVGPath: topRightSVGPath,
      ),
    );
  }
}
