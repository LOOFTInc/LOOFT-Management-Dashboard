import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/widgets/iot_device_details_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_horizontal_padding.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';

class AddIoTDevicePage extends StatelessWidget {
  /// A page to add an IoT Device
  const AddIoTDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashboardResponsiveHorizontalPadding(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap28(),
              IoTDeviceDetailsCard(
                onUpdated: () {
                  context.goNamed(AppRoutes.iotDevicesRoute.name);
                },
              ),
              const Gap28(),
            ],
          ),
        ),
      ),
    );
  }
}
