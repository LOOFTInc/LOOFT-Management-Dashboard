import 'package:country/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:management_dashboard/data/models/enums/subscription_types.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_date_form_field.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_drop_down_field.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_searchable_drop_down_field.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_container.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../../../../../constants.dart';
import '../../../../widgets/text_widgets/custom_text.dart';
import '../../widgets/forms/dashboard_text_form_field.dart';

class CustomerProfileDetailsCard extends StatefulWidget {
  /// A card to display the customer profile details
  const CustomerProfileDetailsCard({
    super.key,
    this.edit = false,
  });

  /// Is this card in edit mode
  final bool edit;

  @override
  State<CustomerProfileDetailsCard> createState() =>
      _CustomerProfileDetailsCardState();
}

class _CustomerProfileDetailsCardState
    extends State<CustomerProfileDetailsCard> {
  /// The form key
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < K.mobileSize;

    return DashboardResponsiveContainer(
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  '${widget.edit ? 'Edit' : 'Add'} Customer Profile Details',
                  style: K.headingStyleDashboard,
                ),
                const Gap16(changeForMobile: false),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 600,
                        child: Column(
                          children: [
                            Responsive(
                              runSpacing: K.gap16Mobile,
                              children: [
                                Div(
                                  divison: const Division(colM: 6),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: isMobile ? 0 : 16),
                                    child: DashboardTextFormField(
                                      name: 'firstName',
                                      hint: 'First Name',
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                    ),
                                  ),
                                ),
                                Div(
                                  divison: const Division(colM: 6),
                                  child: DashboardTextFormField(
                                    name: 'lastName',
                                    hint: 'Last Name',
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                            const Gap16(),
                            DashboardTextFormField(
                              label: 'Contact Phone',
                              name: 'phone',
                              hint: '0213276454935',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.numeric(),
                              ]),
                            ),
                            const Gap16(),
                            DashboardTextFormField(
                              label: 'Address',
                              name: 'address',
                              hint: 'Dream Lane, Heaven Island',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                            const Gap16(),
                            DashboardTextFormField(
                              label: 'Zip Code',
                              name: 'zip',
                              hint: 'HEA-VEN',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                            const Gap16(),
                            DashboardSearchableDropDownField(
                              label: 'Country',
                              name: 'Country',
                              initialValue: Countries.usa.isoShortName,
                              items: Countries.values
                                  .map((e) => e.isoShortName)
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      const Gap16(),
                      DashboardDropDownField(
                        label: 'Customer Type',
                        name: 'subscription',
                        initialValue: SubscriptionTypes.lite.name,
                        stringItems: SubscriptionTypes.values
                            .map((e) => e.name)
                            .toList(),
                      ),
                      const Gap16(),
                      const DashboardDateFormField(
                        label: 'Next Bill Due',
                        name: 'billDue',
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
