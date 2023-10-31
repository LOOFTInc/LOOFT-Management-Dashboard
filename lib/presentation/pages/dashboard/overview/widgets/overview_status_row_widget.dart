import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../../../../../constants.dart';
import 'overview_status_widget.dart';

class OverviewStatusRowWidget extends StatelessWidget {
  /// Shows a row of overview status widgets
  const OverviewStatusRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      runSpacing: MediaQuery.of(context).size.width < K.mobileSize ? 14 : 28,
      children: const [
        OverviewStatusWidget(
          title: 'Total Units',
          value: 417000,
          percentage: 11.01,
          backgroundColor: K.blueE3F5FF,
        ),
        OverviewStatusWidget(
          title: 'Active Units',
          value: 367000,
          percentage: 9.15,
          backgroundColor: K.purpleE5ECF6,
        ),
        OverviewStatusWidget(
          title: 'Non Active Units',
          value: 50000,
          percentage: -0.56,
          backgroundColor: K.blueE3F5FF,
        ),
        OverviewStatusWidget(
          title: 'Faulty Units ',
          value: 2,
          percentage: -1.48,
          backgroundColor: K.pinkFFDEDE,
        ),
      ],
    );
  }
}
