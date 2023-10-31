import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/iot_device_template.dart';
import 'package:management_dashboard/data/models/enums/device_template_device_types.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_drop_down_field.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_text_form_field.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_container.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_text_button.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class IoTDeviceTemplateNameCard extends StatelessWidget {
  /// A card to show the name of the device template
  const IoTDeviceTemplateNameCard({
    super.key,
    required this.template,
    this.onSaveChangesPressed,
  });

  /// The template to edit
  final IoTDeviceTemplate template;

  /// Callback to save the changes
  final VoidCallback? onSaveChangesPressed;

  @override
  Widget build(BuildContext context) {
    return DashboardResponsiveContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                template.templateID == ''
                    ? 'New Device Template'
                    : 'Edit Device Template',
                style: K.headingStyleDashboard,
              ),
              const Gap16(changeForMobile: false),
              CustomTextButton(
                text: 'Save Changes',
                fontSize: 12,
                onPressed: onSaveChangesPressed,
              ),
            ],
          ),
          const Gap16(),
          SizedBox(
            width: 300,
            child: DashboardTextFormField(
              name: 'templateName',
              hint: 'Device Template Name',
              initialValue: template.templateName,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
              onChanged: (value) {
                if (value != null) {
                  template.templateName = value;
                }
              },
            ),
          ),
          const Gap16(),
          SizedBox(
            width: 600,
            child: DashboardDropDownField(
              name: 'deviceType',
              label: 'Device Type',
              initialValue: template.deviceType,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
              widgetItems: DeviceTemplateDeviceTypes.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.displayName,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  template.deviceType = value as DeviceTemplateDeviceTypes;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
