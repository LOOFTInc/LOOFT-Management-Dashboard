import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/data/models/classes/iot_device.dart';
import 'package:management_dashboard/logic/blocs/iot_devices_list/iot_devices_list_bloc.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/tabs/iot_device_manage_tab.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/tabs/iot_device_overview_tab.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/tabs/iot_device_settings_tab.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/widgets/responsive_padding_for_tabs.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tab_view_switching_widget.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';

import '../../../../../../logic/cubits/global_observables/global_observables_cubit.dart';

class IoTDeviceDetailsPage extends StatefulWidget {
  /// A page to display details of an IoT Device
  const IoTDeviceDetailsPage({
    super.key,
    required this.deviceID,
  });

  /// IoT Device to display
  final String deviceID;

  @override
  State<IoTDeviceDetailsPage> createState() => _IoTDeviceDetailsPageState();
}

class _IoTDeviceDetailsPageState extends State<IoTDeviceDetailsPage>
    with SingleTickerProviderStateMixin {
  late final IoTDevice? device;

  /// Tab Controller for the tab view
  late final TabController tabController =
      TabController(length: tabs.length, vsync: this);

  /// List of tabs to be displayed
  List<String> tabs = [
    'Overview',
    'Manage',
    'Settings',
  ];

  /// List of tab views to be displayed
  late final List<Widget> tabViews;

  /// Global Observables Cubit
  late final GlobalObservablesCubit globalObservablesCubit =
      BlocProvider.of<GlobalObservablesCubit>(context);

  @override
  void initState() {
    super.initState();

    device = BlocProvider.of<IoTDevicesListBloc>(context)
        .getDeviceFromID(widget.deviceID);
    if (device == null) {
      context.goNamed(AppRoutes.iotDevicesRoute.name);
      return;
    }

    tabViews = [
      IoTDeviceOverviewTab(
        device: device!,
      ),
      const IoTDeviceManageTab(),
      IoTDeviceSettingsTab(
        device: device!,
        goToHomeTab: () {
          tabController.animateTo(0);
        },
      ),
    ];

    globalObservablesCubit.appendToPath(device?.deviceName ?? '?');
    globalObservablesCubit.selectIoTPlatformAnalytics();
  }

  @override
  void dispose() {
    globalObservablesCubit.unselectIoTPlatformAnalytics();
    globalObservablesCubit.removeLastFromPath();
    tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (device == null) {
      return const SizedBox();
    }

    assert(tabs.length == tabViews.length);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsivePaddingForTabs(
            top: true,
            child: TabViewSwitchingWidget(
              tabs: tabs,
              tabController: tabController,
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: tabs
                  .map(
                    (e) => tabViews.elementAt(tabs.indexOf(e)),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
