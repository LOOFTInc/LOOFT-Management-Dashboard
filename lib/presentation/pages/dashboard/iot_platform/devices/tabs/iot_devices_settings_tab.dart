import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/widgets/responsive_padding_for_tabs.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/widgets/iot_settings_add_device_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/widgets/iot_settings_device_templates_card.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';

class IoTDevicesSettingsTab extends StatelessWidget {
  /// Tab for the IoT Devices Settings
  const IoTDevicesSettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: ResponsivePaddingForTabs(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IoTSettingsAddDeviceCard(),
              Gap16(),
              IoTSettingsDeviceTemplatesCard(),
              Gap28(),
            ],
          ),
        ),
      ),
    );
  }
}
