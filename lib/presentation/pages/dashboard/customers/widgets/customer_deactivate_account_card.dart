import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_form_info_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_container.dart';
import 'package:management_dashboard/presentation/widgets/custom_check_box.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text_span.dart';

import '../../../../../constants.dart';
import '../../../../widgets/buttons/custom_text_button.dart';
import '../../../../widgets/text_widgets/custom_text.dart';

class CustomerDeactivateAccountCard extends StatefulWidget {
  /// A card to deactivate the customer account
  const CustomerDeactivateAccountCard({super.key});

  @override
  State<CustomerDeactivateAccountCard> createState() =>
      _CustomerDeactivateAccountCardState();
}

class _CustomerDeactivateAccountCardState
    extends State<CustomerDeactivateAccountCard> {
  bool confirm = false;

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
                      'Deactivate Account',
                      style: K.headingStyleDashboard,
                    ),
                    Gap16(),
                    CustomTextButton(
                      text: 'Deactivate Account',
                      fontSize: 12,
                      backgroundColor: K.redFF4747,
                      textColor: K.white,
                    ),
                  ],
                ),
                const Gap16(changeForMobile: false),
                DashboardFormInfoCard(
                  leading: const CustomSvg(
                    svgPath: 'assets/icons/warning_circle.svg',
                  ),
                  headingText: 'You Are Deactivating Your Account',
                  subTitle: CustomRichText(
                    style: const TextStyle(fontSize: 12),
                    opacity: OpacityColors.op40,
                    textSpanList: [
                      const TextSpan(
                        text:
                            "For extra security, this requires you to confirm your email or phone number when you reset your password. ",
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
                Row(
                  children: [
                    CustomCheckBox(
                      value: confirm,
                      onChanged: (value) {
                        setState(() {
                          confirm = value ?? false;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const CustomText('I confirm my account deactivation'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
