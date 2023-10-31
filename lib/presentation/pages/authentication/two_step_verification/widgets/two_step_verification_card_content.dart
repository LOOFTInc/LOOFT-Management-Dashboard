import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../constants.dart';
import '../../../../../data/models/enums/opacity_colors.dart';
import '../../../../widgets/buttons/custom_text_button.dart';
import '../../../../widgets/gaps_and_paddings/gap_28.dart';
import '../../../../widgets/text_widgets/custom_text.dart';
import '../../../../widgets/text_widgets/custom_text_span.dart';

class TwoStepVerificationCardContent extends StatefulWidget {
  const TwoStepVerificationCardContent({super.key});

  @override
  State<TwoStepVerificationCardContent> createState() =>
      _TwoStepVerificationCardContentState();
}

class _TwoStepVerificationCardContentState
    extends State<TwoStepVerificationCardContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomSvg(svgPath: 'assets/images/mobile_device.svg'),
        const Gap28(),
        const CustomText(
          'Two Step Verification',
          style: K.headingStyleAuth,
        ),
        const SizedBox(height: 8),
        const CustomText(
          'Please Contact the admin for the verification code',
          opacity: OpacityColors.op40,
        ),
        const Gap28(),
        const CustomText(
          'Type your 6 digit security code',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            final bool isMobile =
                MediaQuery.of(context).size.width < K.mobileSize;

            return PinCodeTextField(
              appContext: context,
              cursorColor: state.opacity40,
              length: 6,
              animationType: AnimationType.fade,
              autoFocus: true,
              enableActiveFill: true,
              pinTheme: PinTheme(
                borderWidth: 1,
                borderRadius: BorderRadius.circular(12),
                fieldWidth: isMobile ? null : 58,
                fieldHeight: isMobile ? null : 58,
                activeFillColor: K.white5,
                selectedFillColor: K.white5,
                selectedColor: state.opacity20,
                inactiveFillColor: K.white5,
                activeColor: state.opacity20,
                inactiveColor: state.opacity10,
                shape: PinCodeFieldShape.box,
                fieldOuterPadding: const EdgeInsets.all(0),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: CustomTextButton(
            text: 'Submit',
            onPressed: () async {
              context.goNamed(AppRoutes.dashboardOverviewRoute.name);
            },
          ),
        ),
        const SizedBox(height: 16),
        CustomRichText(
          textSpanList: [
            const TextSpan(text: "Didn't get the code ? "),
            TextSpan(
              text: 'Resend',
              style: const TextStyle(
                color: K.primaryBlue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.goNamed(AppRoutes.loginRoute.name);
                },
            ),
          ],
        ),
      ],
    );
  }
}
