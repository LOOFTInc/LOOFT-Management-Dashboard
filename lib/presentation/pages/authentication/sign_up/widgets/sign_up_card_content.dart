import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/cubits/authentication/authentication_cubit.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/authentication/widgets/email_divider.dart';
import 'package:management_dashboard/presentation/pages/authentication/widgets/text_link_button.dart';
import 'package:management_dashboard/presentation/pages/authentication/widgets/third_party_login_button.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_text_button.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';
import 'package:password_strength/password_strength.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../widgets/text_widgets/custom_text_span.dart';
import '../../widgets/auth_form_field.dart';

class SignUpCardContent extends StatefulWidget {
  /// The Sign Up card content
  const SignUpCardContent({super.key});

  @override
  State<SignUpCardContent> createState() => _SignUpCardContentState();
}

class _SignUpCardContentState extends State<SignUpCardContent> {
  /// The form key
  final _formKey = GlobalKey<FormBuilderState>();

  /// The password strength
  RxDouble passwordStrength = 0.0.obs;

  /// Did User accept terms
  RxBool acceptTerms = false.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomText(
          'Sign Up',
          style: K.headingStyleAuth,
        ),
        const SizedBox(height: 8),
        const CustomText(
          'LOOFT Management System',
          opacity: OpacityColors.op40,
        ),
        const Gap28(),
        ThirdPartyLoginButton(
          text: 'Sign in with Google',
          svgPath: 'assets/icons/google.svg',
          onPressed: () async {
            await BlocProvider.of<AuthenticationCubit>(context)
                .signInWithGoogle()
                .then((error) {
              if (error == null) {
                context.goNamed(AppRoutes.dashboardOverviewRoute.name);
              } else {
                K.showToast(message: error);
              }
            });
          },
        ),
        const Gap28(),
        const EmailDivider(),
        const Gap28(),
        FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              AuthFormField(
                name: 'email',
                hint: 'Email',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
                onChanged: (val) {
                  _formKey.currentState?.fields['email']?.validate();
                },
              ),
              const SizedBox(height: 16),
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
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(8),
                ]),
                obscureText: true,
                showPasswordToggle: true,
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      return Obx(
                        () => Checkbox(
                          value: acceptTerms.value,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: BorderSide(
                            width: 1.5,
                            color: state.opacity20,
                          ),
                          onChanged: (val) {
                            acceptTerms.value = val ?? false;
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const CustomText('I Accept the '),
                      TextLinkButton(
                        text: 'Terms',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const Gap28(),
        SizedBox(
          width: double.infinity,
          child: CustomTextButton(
            text: 'Sign Up',
            onPressed: () async {
              if (_formKey.currentState?.saveAndValidate() ?? false) {
                final email = _formKey.currentState!.fields['email']!.value;
                final password =
                    _formKey.currentState!.fields['password']!.value;
                final repeatPassword =
                    _formKey.currentState!.fields['repeat_password']!.value;

                if (password != repeatPassword) {
                  _formKey.currentState!.fields['repeat_password']!
                      .invalidate('Passwords do not match');
                  return;
                }

                if (!acceptTerms.value) {
                  K.showToast(message: 'Please accept the terms');
                  return;
                }

                await BlocProvider.of<AuthenticationCubit>(context)
                    .signUpWithEmailAndPassword(
                  email: email,
                  password: password,
                )
                    .then((error) {
                  if (error == null) {
                    context.goNamed(AppRoutes.dashboardOverviewRoute.name);
                  } else {
                    if (error.contains('password')) {
                      _formKey.currentState!.fields['password']!
                          .invalidate(error);
                    } else if (error.contains('email') ||
                        error.contains('user')) {
                      _formKey.currentState!.fields['email']!.invalidate(error);
                    }
                  }
                });
              }
            },
          ),
        ),
        const SizedBox(height: 16),
        CustomRichText(
          textSpanList: [
            const TextSpan(text: 'Already have an Account? '),
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
          opacity: OpacityColors.op40,
        ),
      ],
    );
  }
}
