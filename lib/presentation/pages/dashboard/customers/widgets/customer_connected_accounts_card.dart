import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/connected_account_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_form_info_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_container.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text_span.dart';

import '../../../../../constants.dart';
import '../../../../widgets/text_widgets/custom_text.dart';

class CustomerConnectedAccountsCard extends StatefulWidget {
  /// A card to display the connected accounts of the customer
  const CustomerConnectedAccountsCard({super.key});

  @override
  State<CustomerConnectedAccountsCard> createState() =>
      _CustomerConnectedAccountsCardState();
}

class _CustomerConnectedAccountsCardState
    extends State<CustomerConnectedAccountsCard> {
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
                  'Connected Accounts',
                  style: K.headingStyleDashboard,
                ),
                const Gap16(changeForMobile: false),
                DashboardFormInfoCard(
                  leading: const CustomSvg(
                    svgPath: 'assets/icons/shield_check.svg',
                  ),
                  subTitle: CustomRichText(
                    opacity: OpacityColors.op40,
                    style: const TextStyle(fontSize: 12),
                    textSpanList: [
                      const TextSpan(
                        text:
                            "Two-factor authentication adds an extra layer of security to your account. To log in, in you'll need to provide a 4 digit amazing code.\n",
                      ),
                      TextSpan(
                        text: "Learn more",
                        style: const TextStyle(color: K.primaryBlue),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
                const Gap16(),
                const ConnectedAccountWidget(
                  leadingSvgPath: 'assets/icons/google.svg',
                  title: 'Google',
                  subtitle: 'Plan properly your workflow',
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
