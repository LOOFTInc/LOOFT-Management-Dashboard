import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/pages/dashboard/customers/widgets/customer_connected_accounts_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/customers/widgets/customer_deactivate_account_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/customers/widgets/customer_email_preferences_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/customers/widgets/customer_name_image_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/customers/widgets/customer_notifications_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/customers/widgets/customer_profile_details_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/customers/widgets/customer_sign_in_method_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_horizontal_padding.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';
import 'package:management_dashboard/presentation/widgets/locked_for_production.dart';

import '../widgets/custom_back_button.dart';

class AddCustomerPage extends StatelessWidget {
  /// Add Customer page inside the Dashboard
  const AddCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LockedForProduction(
      child: Scaffold(
        body: DashboardResponsiveHorizontalPadding(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap28(),
                CustomBackButton(),
                Gap16(),
                CustomerNameImageWidget(),
                Gap16(),
                CustomerProfileDetailsCard(),
                Gap16(),
                CustomerSignInMethodCard(),
                Gap16(),
                CustomerConnectedAccountsCard(),
                Gap16(),
                CustomerEmailPreferencesCard(),
                Gap16(),
                CustomerNotificationsCard(),
                Gap16(),
                CustomerDeactivateAccountCard(),
                Gap28(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
