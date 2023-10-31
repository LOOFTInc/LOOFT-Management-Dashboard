import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_container.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';

import '../../../../../constants.dart';
import '../../../../widgets/text_widgets/custom_text.dart';
import '../../widgets/forms/dashboard_text_form_field.dart';

class CustomerSignInMethodCard extends StatefulWidget {
  /// A card to display the customer sign-in method
  const CustomerSignInMethodCard({super.key});

  @override
  State<CustomerSignInMethodCard> createState() =>
      _CustomerSignInMethodCardState();
}

class _CustomerSignInMethodCardState extends State<CustomerSignInMethodCard> {
  /// The form key
  final _formKey = GlobalKey<FormBuilderState>();

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
                  'Sign-in Method',
                  style: K.headingStyleDashboard,
                ),
                const Gap16(changeForMobile: false),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      DashboardTextFormField(
                        label: 'Email Address',
                        name: 'email',
                        hint: 'byewind@snowui.com',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                      ),
                      const Gap16(),
                      DashboardTextFormField(
                        label: 'Password',
                        name: 'password',
                        hint: '*****************',
                        obscureText: true,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(8),
                        ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
