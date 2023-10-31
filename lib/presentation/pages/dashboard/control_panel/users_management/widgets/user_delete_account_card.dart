import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/custom_user.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/logic/cubits/user_management/user_management_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_form_info_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_container.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_text_button.dart';
import 'package:management_dashboard/presentation/widgets/custom_check_box.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text_span.dart';

class UserDeleteAccountCard extends StatefulWidget {
  /// A card to deactivate the User account
  const UserDeleteAccountCard({super.key, this.user});

  /// User to delete
  final CustomUser? user;

  @override
  State<UserDeleteAccountCard> createState() => _UserDeleteAccountCardState();
}

class _UserDeleteAccountCardState extends State<UserDeleteAccountCard> {
  /// A boolean to confirm the deletion
  RxBool confirm = false.obs;

  @override
  Widget build(BuildContext context) {
    return DashboardResponsiveContainer(
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      'Delete Account',
                      style: K.headingStyleDashboard,
                    ),
                    const Gap16(),
                    CustomTextButton(
                      text: 'Delete Account',
                      fontSize: 12,
                      backgroundColor: K.redFF4747,
                      textColor: K.white,
                      onPressed: () async {
                        if (confirm.value) {
                          await BlocProvider.of<UserManagementCubit>(context)
                              .deleteUser(user: widget.user!)
                              .then((error) {
                            if (error == null) {
                              K.showToast(message: 'User deleted successfully');
                              context
                                  .goNamed(AppRoutes.usersManagementRoute.name);
                            } else {
                              K.showToast(message: error);
                            }
                          });
                        } else {
                          K.showToast(
                              message: 'Please confirm the deletion first');
                        }
                      },
                    ),
                  ],
                ),
                const Gap16(changeForMobile: false),
                DashboardFormInfoCard(
                  leading: const CustomSvg(
                    svgPath: 'assets/icons/warning_circle.svg',
                  ),
                  headingText: 'You Are Deleting this Account',
                  subTitle: CustomRichText(
                    style: const TextStyle(fontSize: 12),
                    opacity: OpacityColors.op40,
                    textSpanList: [
                      const TextSpan(
                        text:
                            "For extra security, this requires you to be the account holder or an admin. ",
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
                    Obx(
                      () => CustomCheckBox(
                        value: confirm.value,
                        onChanged: (value) {
                          confirm.value = value ?? false;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    const CustomText('I confirm my account deletion'),
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
