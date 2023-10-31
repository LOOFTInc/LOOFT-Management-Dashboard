import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/widgets/responsive_padding_for_tabs.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';

class IoTDeviceManageTab extends StatelessWidget {
  const IoTDeviceManageTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsivePaddingForTabs(
      child: Column(
        children: [
          Gap16(),
          Placeholder(),
        ],
      ),
    );
  }
}
