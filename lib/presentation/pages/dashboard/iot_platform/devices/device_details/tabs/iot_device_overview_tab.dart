import 'package:flutter/material.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/iot_device.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/widgets/device_name_last_updated_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/widgets/iot_device_listeners_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/widgets/iot_device_location_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/widgets/iot_device_realtime_data_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/widgets/iot_device_timeline_data_graph_container.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/widgets/responsive_padding_for_tabs.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/responsive_row.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';

class IoTDeviceOverviewTab extends StatefulWidget {
  /// A widget to display the overview tab for an IoT device
  const IoTDeviceOverviewTab({
    super.key,
    required this.device,
  });

  /// IoT Device to display the overview tab for
  final IoTDevice device;

  @override
  State<IoTDeviceOverviewTab> createState() => _IoTDeviceOverviewTabState();
}

class _IoTDeviceOverviewTabState extends State<IoTDeviceOverviewTab> {
  ScrollPhysics scrollPhysics = const ScrollPhysics();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: scrollPhysics,
      child: ResponsivePaddingForTabs(
        child: Column(
          children: [
            const Gap16(),
            DeviceNameLastUpdatedCard(
              device: widget.device,
            ),
            const Gap16(),
            ResponsiveRow(
              horizontalGapWidget: const Gap16(isHorizontal: true),
              verticalGapWidget: const Gap16(),
              leftExpanded: true,
              rightExpanded: true,
              leftWidget: SizedBox(
                height: 400,
                child: IoTDeviceRealtimeDataWidget(
                  device: widget.device,
                ),
              ),
              rightWidget: SizedBox(
                height: 400,
                child: IoTDeviceLocationWidget(
                  device: widget.device,
                ),
              ),
              breakWidth: K.maxScreenWidth,
            ),
            const Gap16(),
            IoTDeviceTimelineDataGraphContainer(
              device: widget.device,
              stopScroll: () {
                setState(() {
                  scrollPhysics = const NeverScrollableScrollPhysics();
                });
              },
              resumeScroll: () {
                setState(() {
                  scrollPhysics = const ScrollPhysics();
                });
              },
            ),
            const Gap16(),
            IoTDeviceListenersWidget(
              device: widget.device,
            ),
            const Gap16(),
          ],
        ),
      ),
    );
  }
}
