import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/logic/cubits/authentication/authentication_cubit.dart';
import 'package:management_dashboard/presentation/pages/authentication/widgets/email_divider.dart';
import 'package:management_dashboard/presentation/pages/authentication/widgets/text_link_button.dart';
import 'package:management_dashboard/presentation/pages/authentication/widgets/third_party_login_button.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_text_button.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/responsive_padding.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text_span.dart';

import '../../../../widgets/gaps_and_paddings/gap_28.dart';
import '../../widgets/auth_form_field.dart';

class LoginCard extends StatefulWidget {
  /// The login card for the app
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  /// The form key
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 486,
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ResponsivePadding(
          padding: const EdgeInsets.all(48),
          mobilePadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomText(
                'Sign In',
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
                      onChanged: (value) {
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
                      onChanged: (value) {
                        _formKey.currentState?.fields['password']?.validate();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextLinkButton(
                  text: 'Forgot Password?',
                  onPressed: () {
                    context.goNamed(AppRoutes.forgotPasswordRoute.name);
                  },
                ),
              ),
              const Gap28(),
              SizedBox(
                width: double.infinity,
                child: CustomTextButton(
                  text: 'Sign In',
                  onPressed: () async {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      final email =
                          _formKey.currentState!.fields['email']!.value;
                      final password =
                          _formKey.currentState!.fields['password']!.value;

                      await BlocProvider.of<AuthenticationCubit>(context)
                          .signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      )
                          .then((error) {
                        if (error == null) {
                          context
                              .goNamed(AppRoutes.dashboardOverviewRoute.name);
                        } else {
                          if (error.contains('password')) {
                            _formKey.currentState!.fields['password']!
                                .invalidate(error);
                          } else if (error.contains('email') ||
                              error.contains('user')) {
                            _formKey.currentState!.fields['email']!
                                .invalidate(error);
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
                  const TextSpan(text: 'Not a Member yet? '),
                  TextSpan(
                    text: 'Sign Up',
                    style: const TextStyle(
                      color: K.primaryBlue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.goNamed(AppRoutes.signUpRoute.name);
                      },
                  ),
                ],
                opacity: OpacityColors.op40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
