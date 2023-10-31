import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/presentation/pages/dashboard/overview/widgets/maintenance_requests_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/overview/widgets/online_and_faulty_units_graph.dart';
import 'package:management_dashboard/presentation/pages/dashboard/overview/widgets/overview_status_row_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/overview/widgets/users_by_device_graph.dart';
import 'package:management_dashboard/presentation/pages/dashboard/overview/widgets/users_by_location_graph.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/responsive_row.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/responsive_padding.dart';
import 'package:management_dashboard/presentation/widgets/locked_for_production.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

import '../../../widgets/custom_svg.dart';

class OverviewPage extends StatelessWidget {
  /// Dashboard overview page
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    const double maxWidth = 920;

    return Scaffold(
      body: LockedForProduction(
        child: ResponsivePadding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap28(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CustomText(
                          'Today',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Transform.rotate(
                          angle: math.pi / 2,
                          child: const CustomSvg(
                            svgPath: 'assets/icons/chevron_right.svg',
                            opacity: OpacityColors.op40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(
                      width: maxWidth, child: OverviewStatusRowWidget()),
                  const Gap28(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: [
                        ResponsiveRow(
                          leftWidget: OnlineAndFaultyUnitsGraph(),
                          rightWidget: MaintenanceRequestsWidget(),
                          breakWidth: maxWidth + 40,
                          reverse: true,
                        ),
                        Gap28(),
                        ResponsiveRow(
                          leftWidget: UsersByDeviceGraph(),
                          rightWidget: UsersByLocationGraph(),
                          breakWidth: maxWidth + 40,
                        ),
                        Gap28(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
