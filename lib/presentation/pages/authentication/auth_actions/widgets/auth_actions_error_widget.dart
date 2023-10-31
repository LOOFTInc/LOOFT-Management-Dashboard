import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_text_button.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class AuthActionsErrorWidget extends StatelessWidget {
  /// The auth actions error widget
  const AuthActionsErrorWidget({
    super.key,
    this.errorMessage,
  });

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const CustomText(
            'Woops!',
            style: K.headingStyleAuth,
          ),
          const Gap28(),
          CustomText(
            errorMessage ??
                'Seems like you have stumbled upon the wrong page. Kindly go back.',
            textAlign: TextAlign.center,
          ),
          const Gap16(),
          SizedBox(
            width: double.infinity,
            child: CustomTextButton(
              text: 'Sign in',
              onPressed: () {
                context.goNamed(AppRoutes.loginRoute.name);
              },
            ),
          ),
        ],
      ),
    );
  }
}
