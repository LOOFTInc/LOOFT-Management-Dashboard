import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/widgets/responsive_padding_for_tabs.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/widgets/iot_devices_table_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tables/table_function_bar.dart';
import 'package:management_dashboard/presentation/widgets/scrollable_widget.dart';

class IoTDevicesListTab extends StatefulWidget {
  /// Tab for IoT Devices List
  const IoTDevicesListTab({super.key});

  @override
  State<IoTDevicesListTab> createState() => _IoTDevicesListTabState();
}

class _IoTDevicesListTabState extends State<IoTDevicesListTab> {
  /// Value to search in the table
  String searchValue = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ResponsivePaddingForTabs(
          child: TableFunctionBar(
            onSearch: (value) {
              setState(() {
                searchValue = value;
              });
            },
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ScrollableWidget(
            scrollDirection: Axis.horizontal,
            minSize: 1100,
            widgetSize: 1100,
            child: ResponsivePaddingForTabs(
              child: IoTDevicesTableWidget(
                searchValue: searchValue.toLowerCase(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
