import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/logic/cubits/authentication/authentication_cubit.dart';
import 'package:management_dashboard/presentation/pages/authentication/widgets/text_link_button.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';

import '../../../../../constants.dart';
import '../../../../../data/models/enums/opacity_colors.dart';
import '../../../../widgets/buttons/custom_text_button.dart';
import '../../../../widgets/text_widgets/custom_text.dart';
import '../../widgets/auth_form_field.dart';

class ForgotPasswordCardContent extends StatefulWidget {
  /// The Forgot password card content
  const ForgotPasswordCardContent({super.key});

  @override
  State<ForgotPasswordCardContent> createState() =>
      _ForgotPasswordCardContentState();
}

class _ForgotPasswordCardContentState extends State<ForgotPasswordCardContent> {
  /// The form key
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomText(
          'Forgot Password ?',
          style: K.headingStyleAuth,
        ),
        const SizedBox(height: 8),
        const CustomText(
          'Enter your email to reset your password.',
          opacity: OpacityColors.op40,
        ),
        const Gap28(),
        FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              AuthFormField(
                name: 'email',
                hint: 'Please enter your email address',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
                onChanged: (value) {
                  _formKey.currentState!.fields['email']!.validate();
                },
              ),
            ],
          ),
        ),
        const Gap28(),
        SizedBox(
          width: double.infinity,
          child: CustomTextButton(
            text: 'Submit',
            onPressed: () async {
              if (_formKey.currentState!.saveAndValidate()) {
                final String? error =
                    await BlocProvider.of<AuthenticationCubit>(context)
                        .sendPasswordResetEmail(
                  email:
                      _formKey.currentState!.fields['email']!.value as String,
                );

                if (error == null) {
                  K.showToast(message: 'Please check your email');
                } else {
                  _formKey.currentState!.fields['email']!.invalidate(error);
                }
              }
            },
          ),
        ),
        const SizedBox(height: 16),
        TextLinkButton(
          text: 'Back',
          onPressed: () {
            context.goNamed(AppRoutes.loginRoute.name);
          },
        ),
      ],
    );
  }
}
