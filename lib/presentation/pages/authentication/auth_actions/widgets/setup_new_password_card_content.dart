import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/cubits/authentication/authentication_cubit.dart';
import 'package:management_dashboard/presentation/pages/authentication/auth_actions/widgets/auth_actions_error_widget.dart';
import 'package:password_strength/password_strength.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../../constants.dart';
import '../../../../../data/models/enums/opacity_colors.dart';
import '../../../../../logic/cubits/theme/theme_cubit.dart';
import '../../../../routing/app_routes.dart';
import '../../../../widgets/buttons/custom_text_button.dart';
import '../../../../widgets/gaps_and_paddings/gap_28.dart';
import '../../../../widgets/text_widgets/custom_text.dart';
import '../../../../widgets/text_widgets/custom_text_span.dart';
import '../../widgets/auth_form_field.dart';

class SetupNewPasswordCardContent extends StatefulWidget {
  /// The setup new password card content
  const SetupNewPasswordCardContent({
    super.key,
    required this.code,
  });

  /// The Password reset code
  final String code;

  @override
  State<SetupNewPasswordCardContent> createState() =>
      _SetupNewPasswordCardContentState();
}

class _SetupNewPasswordCardContentState
    extends State<SetupNewPasswordCardContent> {
  /// The form key
  final _formKey = GlobalKey<FormBuilderState>();

  /// The password strength
  RxDouble passwordStrength = 0.0.obs;

  /// The loading state
  bool loading = false;

  /// The error message
  String? errorMessage =
      'Seems like you have stumbled upon the wrong page. Kindly go back.';

  /// The password
  String password = '';

  @override
  void initState() {
    super.initState();

    verifyCode();
  }

  /// Verifies the reset code
  void verifyCode() async {
    setState(() {
      loading = true;
    });

    final String? error = await BlocProvider.of<AuthenticationCubit>(context)
        .verifyResetPasswordCode(
      code: widget.code,
    );
    setState(() {
      errorMessage = error;
    });

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return AuthActionsErrorWidget(
        errorMessage: errorMessage,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomText(
          'Setup New Password',
          style: K.headingStyleAuth,
        ),
        const SizedBox(height: 8),
        CustomRichText(
          textSpanList: [
            const TextSpan(text: "Have you already reset the password ? "),
            TextSpan(
              text: 'Sign in',
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
        const Gap28(),
        FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              AuthFormField(
                name: 'password',
                hint: 'Password',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(8),
                ]),
                obscureText: true,
                showPasswordToggle: true,
                onChanged: (val) {
                  setState(() {
                    password = val ?? '';
                  });
                  _formKey.currentState?.fields['password']?.validate();
                  passwordStrength.value = estimatePasswordStrength(val ?? '');
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, state) {
                    return Obx(
                      () => StepProgressIndicator(
                        totalSteps: 4,
                        roundedEdges: const Radius.circular(2),
                        currentStep: HelperFunctions.getPasswordStrengthStep(
                            passwordStrength.value),
                        selectedColor: state.opacity40,
                        unselectedColor: state.opacity10,
                      ),
                    );
                  },
                ),
              ),
              const CustomText(
                'Use 8 or more characters with a mix of letters, numbers & symbols.',
                opacity: OpacityColors.op40,
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 16),
              AuthFormField(
                name: 'repeat_password',
                hint: 'Repeat Password',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.equal(
                    password,
                    errorText: 'Passwords do not match',
                  ),
                ]),
                obscureText: true,
                showPasswordToggle: true,
                onChanged: (val) {
                  _formKey.currentState?.fields['repeat_password']?.validate();
                },
              ),
              const Gap28(),
              SizedBox(
                width: double.infinity,
                child: CustomTextButton(
                  text: 'Submit',
                  onPressed: () async {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      final String? error =
                          await BlocProvider.of<AuthenticationCubit>(context)
                              .resetPassword(
                        code: widget.code,
                        password:
                            _formKey.currentState?.fields['password']?.value,
                      );

                      if (error == null) {
                        K.showToast(
                            message:
                                'Password reset successfully. You can now Sign in.');
                        context.goNamed(AppRoutes.loginRoute.name);
                      } else {
                        setState(() {
                          errorMessage = error;
                        });
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
