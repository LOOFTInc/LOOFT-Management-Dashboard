import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_form_info_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_container.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_text_button.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class IoTSettingsAddDeviceCard extends StatelessWidget {
  /// Card to display the Add Device Card
  const IoTSettingsAddDeviceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardResponsiveContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                'Add Device',
                style: K.headingStyleDashboard,
              ),
              CustomTextButton(
                text: 'Add New Device',
                fontSize: 12,
                onPressed: () {
                  context.goNamed(AppRoutes.addIotDeviceRoute.name);
                },
              ),
            ],
          ),
          const Gap16(changeForMobile: false),
          const DashboardFormInfoCard(
            leading: CustomSvg(
              svgPath: 'assets/icons/warning_circle.svg',
            ),
            headingText: 'Add a new device in the IoT Platform',
            subTitleText:
                'For extra security, this requires you to be an Manager or Admin.',
          ),
        ],
      ),
    );
  }
}
