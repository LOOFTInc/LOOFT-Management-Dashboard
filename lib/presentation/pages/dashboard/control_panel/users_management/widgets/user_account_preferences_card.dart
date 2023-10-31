import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/enums/account_roles.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/form_divider_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/preferences_selection_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_container.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class UserAccountPreferencesCard extends StatelessWidget {
  /// user Account Preferences Card
  const UserAccountPreferencesCard({
    super.key,
    required this.accountRole,
  });

  /// The account type of the user
  final Rx<AccountRoles> accountRole;

  @override
  Widget build(BuildContext context) {
    return DashboardResponsiveContainer(
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  'Account Permissions',
                  style: K.headingStyleDashboard,
                ),
                const Gap16(),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final AccountRoles accountRole = AccountRoles.values[index];
                    return Obx(
                      () => PreferencesSelectionWidget(
                        title: accountRole.name,
                        subtitle: accountRole.description,
                        selected: this.accountRole.value == accountRole,
                        onChanged: (bool? value) {
                          this.accountRole.value = accountRole;
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const FormDividerWidget();
                  },
                  itemCount: AccountRoles.values.length,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
