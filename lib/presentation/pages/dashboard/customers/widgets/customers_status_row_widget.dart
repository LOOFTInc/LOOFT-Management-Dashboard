import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../../../../../constants.dart';
import 'customers_status_widget.dart';

class CustomersStatusRowWidget extends StatelessWidget {
  /// Shows a row of overview status widgets
  const CustomersStatusRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      runSpacing: 28,
      children: [
        CustomersStatusWidget(
          title: 'Current Customers',
          value: 237,
          percentage: 11.01,
          backgroundColor: K.blueE3F5FF,
          topRightSVGPath: 'assets/icons/folder.svg',
        ),
        CustomersStatusWidget(
          title: 'Monthly Revenue',
          value: 3290,
          percentage: 9.15,
          backgroundColor: K.purpleE5ECF6,
          topRightSVGPath: 'assets/icons/currency_dollar.svg',
          isMoney: true,
        ),
        CustomersStatusWidget(
          title: 'New Customers',
          value: 49,
          percentage: -0.56,
          backgroundColor: K.blueE3F5FF,
          topRightSVGPath: 'assets/icons/users_three.svg',
        ),
      ],
    );
  }
}
