import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/logic/cubits/authentication/authentication_cubit.dart';
import 'package:management_dashboard/logic/cubits/user_management/user_management_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/control_panel/users_management/tabs/users_admin_tab.dart';
import 'package:management_dashboard/presentation/pages/dashboard/control_panel/users_management/tabs/users_manage_tab.dart';
import 'package:management_dashboard/presentation/pages/dashboard/control_panel/users_management/tabs/users_monitor_tab.dart';
import 'package:management_dashboard/presentation/pages/dashboard/control_panel/users_management/tabs/users_settings_tab.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/widgets/responsive_padding_for_tabs.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tab_view_switching_widget.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/buttons/rounded_text_button.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class UsersManagementPage extends StatefulWidget {
  /// Customers page inside the Dashboard
  const UsersManagementPage({super.key});

  @override
  State<UsersManagementPage> createState() => _UsersManagementPageState();
}

class _UsersManagementPageState extends State<UsersManagementPage>
    with SingleTickerProviderStateMixin {
  /// Tab Controller for the tab view
  late final TabController tabController;

  /// List of tabs to be displayed
  List<String> tabs = [
    'Monitor',
    'Manage',
    'Admin',
    'Settings',
  ];

  /// List of tab views to be displayed
  List<Widget> tabViews = [
    const UsersMonitorTab(),
    const UsersManageTab(),
    const UsersAdminTab(),
    const UsersSettingsTab(),
  ];

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: tabs.length, vsync: this);

    BlocProvider.of<UserManagementCubit>(context).initCubit(
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
                    context.goNamed(AppRoutes.addUserRoute.name);
                  },
                  child: const CustomText(
                    '+ Add User',
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
