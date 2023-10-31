import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/data/models/enums/account_roles.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/authentication/account_type_selection/widgets/account_type_widget.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_text_button.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text_span.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../../../../../constants.dart';
import '../../../../../data/models/enums/opacity_colors.dart';
import '../../../../widgets/text_widgets/custom_text.dart';

class AccountTypeSelectionCardContent extends StatefulWidget {
  /// Content of the card in [AccountTypeSelectionPage]
  const AccountTypeSelectionCardContent({super.key});

  @override
  State<AccountTypeSelectionCardContent> createState() =>
      _AccountTypeSelectionCardContentState();
}

class _AccountTypeSelectionCardContentState
    extends State<AccountTypeSelectionCardContent> {
  Rx<AccountRoles> selectedAccountType = AccountRoles.monitor.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomText(
          'Choose Account Type',
          style: K.headingStyleAuth,
        ),
        const SizedBox(height: 8),
        CustomRichText(
          textSpanList: [
            const TextSpan(text: 'If you need more info, please check out '),
            TextSpan(
              text: 'Help Page',
              recognizer: TapGestureRecognizer()..onTap = () {},
              style: const TextStyle(color: K.primaryBlue),
            ),
            const TextSpan(text: '.'),
          ],
          opacity: OpacityColors.op40,
        ),
        const Gap28(),
        Obx(
          () => Responsive(
            runSpacing: MediaQuery.of(context).size.width < K.mobileSize
                ? K.gap28Mobile
                : K.gap28Desktop,
            children: [
              AccountTypeWidget(
                isSelected: selectedAccountType.value == AccountRoles.monitor,
                svgPath: 'assets/icons/user_circle.svg',
                name: 'Monitor',
                details: 'The user can view only.',
                onPressed: () {
                  selectedAccountType.value = AccountRoles.monitor;
                },
              ),
              AccountTypeWidget(
                isSelected: selectedAccountType.value == AccountRoles.manager,
                svgPath: 'assets/icons/suitcase.svg',
                name: 'Manager',
                details: 'Monitor and Manage.',
                onPressed: () {
                  selectedAccountType.value = AccountRoles.manager;
                },
              ),
              AccountTypeWidget(
                isSelected: selectedAccountType.value == AccountRoles.admin,
                svgPath: 'assets/icons/key.svg',
                name: 'Admin',
                details: 'Complete Control.',
                onPressed: () {
                  selectedAccountType.value = AccountRoles.admin;
                },
              ),
            ],
          ),
        ),
        const Gap28(),
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return CustomTextButton(
              text: '',
              onPressed: () {
                context.goNamed(AppRoutes.twoStepVerificationRoute.name);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 8),
                  CustomText(
                    'Continue',
                    selectable: false,
                    style: TextStyle(
                      color: state.reverseOpacity100,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const CustomSvg(
                    svgPath: 'assets/icons/chevron_right.svg',
                    opacity: OpacityColors.rop100,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
