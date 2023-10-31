import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/presentation/pages/dashboard/customers/tabs/customers_activity_tab.dart';
import 'package:management_dashboard/presentation/pages/dashboard/customers/tabs/customers_billing_tab.dart';
import 'package:management_dashboard/presentation/pages/dashboard/customers/tabs/customers_list_tab.dart';
import 'package:management_dashboard/presentation/pages/dashboard/customers/tabs/customers_logs_tab.dart';
import 'package:management_dashboard/presentation/pages/dashboard/customers/tabs/customers_referrals_tab.dart';
import 'package:management_dashboard/presentation/pages/dashboard/customers/tabs/customers_settings_tab.dart';
import 'package:management_dashboard/presentation/pages/dashboard/customers/tabs/customers_statements_tab.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tab_view_switching_widget.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_popup_button.dart';
import 'package:management_dashboard/presentation/widgets/buttons/rounded_text_button.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/responsive_padding.dart';
import 'package:management_dashboard/presentation/widgets/locked_for_production.dart';
import 'package:management_dashboard/presentation/widgets/scrollable_widget.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

import 'add_customer_page.dart';

class CustomersPage extends StatefulWidget {
  /// Customers page inside the Dashboard
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage>
    with SingleTickerProviderStateMixin {
  /// Tab Controller for the tab view
  late final TabController tabController;

  /// List of tabs to be displayed
  List<String> tabs = [
    'Customers',
    'Activity',
    'Settings',
    'Billing',
    'Statements',
    'Referrals',
    'Logs',
  ];

  /// List of tab views to be displayed
  List<Widget> tabViews = [
    const CustomersListTab(),
    const CustomersActivityTab(),
    const CustomersSettingsTab(),
    const CustomersBillingTab(),
    const CustomersStatementsTab(),
    const CustomersReferralsTab(),
    const CustomersLogsTab(),
  ];

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(tabs.length == tabViews.length);

    return LockedForProduction(
      child: Scaffold(
        body: ScrollableWidget(
          scrollDirection: Axis.horizontal,
          minSize: 1100,
          widgetSize: 1100,
          child: ResponsivePadding(
            padding: const EdgeInsets.fromLTRB(28, 28, 28, 0),
            mobilePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TabViewSwitchingWidget(
                      tabs: tabs,
                      tabController: tabController,
                    ),
                    Row(
                      children: [
                        RoundedTextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const AddCustomerPage(),
                              ),
                            );
                          },
                          child: const CustomText(
                            '+ Add Customer',
                            opacity: OpacityColors.op40,
                            selectable: false,
                          ),
                        ),
                        RoundedTextButton(
                          onPressed: () {},
                          child: const CustomText(
                            'Add Target',
                            opacity: OpacityColors.op40,
                            selectable: false,
                          ),
                        ),
                        const CustomPopupButton(
                          items: [],
                        ),
                      ],
                    ),
                  ],
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
          ),
        ),
      ),
    );
  }
}
