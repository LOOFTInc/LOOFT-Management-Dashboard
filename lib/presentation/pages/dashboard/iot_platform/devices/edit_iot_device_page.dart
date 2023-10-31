import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/data/models/classes/iot_device.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/widgets/iot_device_delete_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/widgets/iot_device_details_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_horizontal_padding.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';

class EditIoTDevicePage extends StatefulWidget {
  /// A page to edit an IoT Device
  const EditIoTDevicePage({
    super.key,
    required this.device,
  });

  /// Iot Device to edit
  final IoTDevice? device;

  @override
  State<EditIoTDevicePage> createState() => _EditIoTDevicePageState();
}

class _EditIoTDevicePageState extends State<EditIoTDevicePage> {
  @override
  void initState() {
    super.initState();

    if (widget.device == null) {
      context.goNamed(AppRoutes.iotDevicesRoute.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.device == null) {
      return const SizedBox();
    }

    return Scaffold(
      body: DashboardResponsiveHorizontalPadding(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap28(),
              IoTDeviceDetailsCard(
                ioTDevice: widget.device,
                onUpdated: () {
                  context.goNamed(AppRoutes.iotDevicesRoute.name);
                },
              ),
              if (widget.device?.deviceName != null) ...[
                const Gap16(),
                IoTDeviceDeleteCard(
                  device: widget.device!,
                  onDeleted: () {
                    context.goNamed(AppRoutes.iotDevicesRoute.name);
                  },
                ),
              ],
              const Gap28(),
            ],
          ),
        ),
      ),
    );
  }
}
