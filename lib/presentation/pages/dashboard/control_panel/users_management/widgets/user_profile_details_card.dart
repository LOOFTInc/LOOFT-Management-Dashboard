import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/custom_user.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_text_form_field.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_container.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class UserProfileDetailsCard extends StatelessWidget {
  /// A card to display the User profile details
  const UserProfileDetailsCard({
    super.key,
    this.user,
  });

  /// User object
  final CustomUser? user;

  @override
  Widget build(BuildContext context) {
    return DashboardResponsiveContainer(
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  '${user != null ? 'Edit' : 'Add'} User Profile Details',
                  style: K.headingStyleDashboard,
                ),
                const Gap16(changeForMobile: false),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 600,
                      child: Column(
                        children: [
                          DashboardTextFormField(
                            label: 'Full Name',
                            name: 'name',
                            hint: 'John Doe',
                            initialValue: user?.displayName,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                          const Gap16(),
                          DashboardTextFormField(
                            label: 'Contact Phone',
                            name: 'phone',
                            hint: '0213276454935',
                            initialValue: user?.phoneNumber,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.numeric(),
                            ]),
                          ),
                        ],
                      ),
                    ),
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
