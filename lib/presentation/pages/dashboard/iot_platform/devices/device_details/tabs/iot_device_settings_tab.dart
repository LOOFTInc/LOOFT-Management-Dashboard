import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/data/models/classes/iot_device.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/widgets/responsive_padding_for_tabs.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/widgets/iot_device_delete_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/widgets/iot_device_details_card.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';

class IoTDeviceSettingsTab extends StatelessWidget {
  /// IoT Device Settings Tab
  const IoTDeviceSettingsTab({
    super.key,
    required this.device,
    required this.goToHomeTab,
  });

  /// IoT Device to edit
  final IoTDevice device;

  /// Callback to go to home Tab
  final VoidCallback goToHomeTab;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsivePaddingForTabs(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap16(),
            IoTDeviceDetailsCard(
              ioTDevice: device,
              onUpdated: goToHomeTab,
            ),
            if (device.deviceName != null) ...[
              const Gap16(),
              IoTDeviceDeleteCard(
                device: device,
                onDeleted: () {
                  context.goNamed(AppRoutes.iotDevicesRoute.name);
                },
              ),
            ],
            const Gap28(),
          ],
        ),
      ),
    );
  }
}
