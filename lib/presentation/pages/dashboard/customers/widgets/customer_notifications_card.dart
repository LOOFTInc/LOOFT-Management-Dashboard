import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/form_divider_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_container.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_text_button.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';

import '../../../../../constants.dart';
import '../../../../../data/models/enums/opacity_colors.dart';
import '../../../../widgets/text_widgets/custom_text.dart';
import '../../widgets/forms/notification_toggle_widget.dart';

class CustomerNotificationsCard extends StatefulWidget {
  /// Customer Notifications Card
  const CustomerNotificationsCard({super.key});

  @override
  State<CustomerNotificationsCard> createState() =>
      _CustomerNotificationsCardState();
}

class _CustomerNotificationsCardState extends State<CustomerNotificationsCard> {
  @override
  Widget build(BuildContext context) {
    return const DashboardResponsiveContainer(
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      'Notifications',
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
                Gap16(),
                NotificationToggleWidget(
                  title: 'Notifications',
                  selected: true,
                ),
                FormDividerWidget(),
                NotificationToggleWidget(
                  title: 'Billing Updates',
                  selected: true,
                ),
                FormDividerWidget(),
                NotificationToggleWidget(
                  title: 'New Team Members',
                  selected: false,
                ),
                FormDividerWidget(),
                NotificationToggleWidget(
                  title: 'Completed Projects',
                  selected: false,
                ),
                FormDividerWidget(),
                NotificationToggleWidget(
                  title: 'Newsletters',
                  selected: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
