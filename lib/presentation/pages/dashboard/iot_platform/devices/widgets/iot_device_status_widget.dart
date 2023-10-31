import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management_dashboard/data/models/enums/iot_device_status.dart';
import 'package:management_dashboard/presentation/pages/dashboard/models/custom_colors.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/colored_text_container.dart';

class IoTDeviceStatusWidget extends StatelessWidget {
  /// IoT Device Status Widget
  /// Adds a Container with a color based on the status
  /// Red for offline, Green for online
  const IoTDeviceStatusWidget({
    super.key,
    required this.status,
  });

  /// IoT Device Status
  final IoTDeviceStatus status;

  @override
  Widget build(BuildContext context) {
    return ColoredTextContainer(
      text: status.name.capitalizeFirst!,
      textColor: status == IoTDeviceStatus.online
          ? CustomColors.green
          : CustomColors.red,
    );
  }
}
