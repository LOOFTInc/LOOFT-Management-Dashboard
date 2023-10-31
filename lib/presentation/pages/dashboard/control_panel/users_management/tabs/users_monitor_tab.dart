import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/pages/dashboard/control_panel/users_management/widgets/users_table_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/widgets/responsive_padding_for_tabs.dart';
import 'package:management_dashboard/presentation/widgets/scrollable_widget.dart';

import '../../../widgets/tables/table_function_bar.dart';

class UsersMonitorTab extends StatefulWidget {
  /// Users List tab
  const UsersMonitorTab({super.key});

  @override
  State<UsersMonitorTab> createState() => _UsersMonitorTabState();
}

class _UsersMonitorTabState extends State<UsersMonitorTab> {
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
            minSize: 900,
            widgetSize: 900,
            child: ResponsivePaddingForTabs(
              child: UsersTableWidget(
                searchValue: searchValue.toLowerCase(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
