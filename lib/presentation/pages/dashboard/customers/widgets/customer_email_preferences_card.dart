import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/form_divider_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/preferences_selection_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_container.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_text_button.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';

import '../../../../../constants.dart';
import '../../../../../data/models/enums/opacity_colors.dart';
import '../../../../widgets/text_widgets/custom_text.dart';

class CustomerEmailPreferencesCard extends StatefulWidget {
  /// Customer Email Preferences Card
  const CustomerEmailPreferencesCard({super.key});

  @override
  State<CustomerEmailPreferencesCard> createState() =>
      _CustomerEmailPreferencesCardState();
}

class _CustomerEmailPreferencesCardState
    extends State<CustomerEmailPreferencesCard> {
  @override
  Widget build(BuildContext context) {
    return DashboardResponsiveContainer(
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      'Email Preferences',
                      style: K.headingStyleDashboard,
                    ),
                    Gap16(changeForMobile: false),
                    Flexible(
                      child: Wrap(
                        runSpacing: 8,
                        verticalDirection: VerticalDirection.up,
                        alignment: WrapAlignment.end,
                        children: [
                          CustomTextButton(
                            text: 'Cancel',
                            fontSize: 12,
                            backgroundOpacityColor: OpacityColors.op5,
                            textOpacityColor: OpacityColors.op100,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: CustomTextButton(
                              text: 'Save Changes',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap16(),
                PreferencesSelectionWidget(
                  title: 'Successful Payments',
                  subtitle:
                      'Receive a notification for every successful payment.',
                  selected: true,
                  onChanged: (bool? value) {},
                ),
                const FormDividerWidget(),
                PreferencesSelectionWidget(
                  title: 'Fee Collection',
                  subtitle:
                      'Receive a notification each time you collect a fee from sales.',
                  selected: true,
                  onChanged: (bool? value) {},
                ),
                const FormDividerWidget(),
                PreferencesSelectionWidget(
                  title: 'Customer Payment Dispute',
                  subtitle:
                      'Receive a notification if a payment is disputed by a customer and for dispute purposes.',
                  selected: false,
                  onChanged: (bool? value) {},
                ),
                const FormDividerWidget(),
                PreferencesSelectionWidget(
                  title: 'Refund Alerts',
                  subtitle:
                      'Receive a notification if a payment is stated as risk by the Finance Department.',
                  selected: false,
                  onChanged: (bool? value) {},
                ),
                const FormDividerWidget(),
                PreferencesSelectionWidget(
                  title: 'Invoice Payments',
                  subtitle:
                      'Receive a notification if a customer sends an incorrect amount to pay their invoice.',
                  selected: false,
                  onChanged: (bool? value) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
