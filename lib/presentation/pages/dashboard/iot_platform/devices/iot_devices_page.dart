import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/logic/blocs/iot_devices_list/iot_devices_list_bloc.dart';
import 'package:management_dashboard/logic/cubits/authentication/authentication_cubit.dart';
import 'package:management_dashboard/logic/cubits/iot_device_templates/iot_device_templates_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/widgets/responsive_padding_for_tabs.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/tabs/iot_devices_list_tab.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/tabs/iot_devices_manage_tab.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/tabs/iot_devices_settings_tab.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tab_view_switching_widget.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/buttons/rounded_text_button.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class IoTDevicesPage extends StatefulWidget {
  /// A page to display the list of IoT Devices
  const IoTDevicesPage({
    super.key,
    this.initialIndex,
  });

  /// The initial index of the tab view
  final int? initialIndex;

  @override
  State<IoTDevicesPage> createState() => _IoTDevicesPageState();
}

class _IoTDevicesPageState extends State<IoTDevicesPage>
    with SingleTickerProviderStateMixin {
  /// Tab Controller for the tab view
  late final TabController tabController;

  /// List of tabs to be displayed
  List<String> tabs = [
    'All Devices',
    'Manage',
    'Settings',
  ];

  /// List of tab views to be displayed
  List<Widget> tabViews = [
    const IoTDevicesListTab(),
    const IoTDevicesManageTab(),
    const IoTDevicesSettingsTab(),
  ];

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: widget.initialIndex ?? 0,
    );

    BlocProvider.of<IoTDevicesListBloc>(context).initBloc(
      authenticationCubit: BlocProvider.of<AuthenticationCubit>(context),
    );
    BlocProvider.of<IoTDeviceTemplatesCubit>(context).initCubit(
      authenticationCubit: BlocProvider.of<AuthenticationCubit>(context),
    );
  }

  @override
  void dispose() {
    tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(tabs.length == tabViews.length);

    return Scaffold(
      body: Column(
        children: [
          ResponsivePaddingForTabs(
            top: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TabViewSwitchingWidget(
                    tabs: tabs,
                    tabController: tabController,
                  ),
                ),
                RoundedTextButton(
                  onPressed: () {
                    context.goNamed(AppRoutes.addIotDeviceRoute.name);
                  },
                  child: const CustomText(
                    '+ Add Device',
                    opacity: OpacityColors.op40,
                    selectable: false,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
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
