import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/iot_device_template.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/cubits/iot_device_templates/iot_device_templates_cubit.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_drop_down_field.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_container.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_popup_button.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_text_button.dart';
import 'package:management_dashboard/presentation/widgets/custom_popup_menu_item.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/dialogs/custom_confirmation_dialog.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class IoTSettingsDeviceTemplatesCard extends StatelessWidget {
  /// Card for the Device Templates
  const IoTSettingsDeviceTemplatesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardResponsiveContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: CustomText(
                  'Device Templates',
                  style: K.headingStyleDashboard,
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: CustomTextButton(
                  text: 'New Device Template',
                  fontSize: 12,
                  onPressed: () {
                    context.goNamed(
                      AppRoutes.newIotTemplateRoute.name,
                    );
                  },
                ),
              ),
            ],
          ),
          const Gap16(changeForMobile: false),
          SizedBox(
            width: 600,
            child:
                BlocBuilder<IoTDeviceTemplatesCubit, IoTDeviceTemplatesState>(
              builder: (context, state) {
                List<IoTDeviceTemplate> templates = state.deviceTemplates;

                IoTDeviceTemplate? initialTemplate =
                    BlocProvider.of<IoTDeviceTemplatesCubit>(context)
                        .getTemplateOrDefault(null);

                return DashboardDropDownField(
                  name: 'defaultTemplate',
                  label: 'Default Template',
                  enabled: templates.isNotEmpty,
                  hint: 'Select a template',
                  initialValue: state.deviceTemplates.isNotEmpty
                      ? initialTemplate
                      : 'No Templates',
                  stringItems: state.deviceTemplates.isNotEmpty
                      ? null
                      : const ['No Templates'],
                  widgetItems: state.deviceTemplates.isEmpty
                      ? null
                      : state.deviceTemplates
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.templateName,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (val) async {
                    if (val != null) {
                      String? error =
                          await BlocProvider.of<IoTDeviceTemplatesCubit>(
                                  context)
                              .setDefaultTemplate(val as IoTDeviceTemplate);

                      if (error != null) {
                        K.showToast(message: error);
                      } else {
                        K.showToast(
                            message: 'Default template set successfully');
                      }
                    }
                  },
                );
              },
            ),
          ),
          BlocBuilder<IoTDeviceTemplatesCubit, IoTDeviceTemplatesState>(
              builder: (context, state) {
            return Column(
              children: state.deviceTemplates
                  .map((e) => Column(
                        children: [
                          const Gap16(),
                          _HelperTemplateWidget(
                            template: e,
                            onDelete: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (dialogContext) =>
                                    CustomConfirmationDialog(
                                  onConfirm: () async {
                                    await BlocProvider.of<
                                            IoTDeviceTemplatesCubit>(context)
                                        .deleteIoTDeviceTemplate(e)
                                        .then((error) {
                                      if (error != null) {
                                        K.showToast(message: error);
                                      } else {
                                        K.showToast(
                                            message:
                                                'Template deleted successfully');
                                      }

                                      Navigator.pop(dialogContext);
                                    });
                                  },
                                  onCancel: () {
                                    Navigator.pop(dialogContext);
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ))
                  .toList(),
            );
          }),
        ],
      ),
    );
  }
}

class _HelperTemplateWidget extends StatelessWidget {
  /// Helper Template Widget
  const _HelperTemplateWidget({
    required this.template,
    required this.onDelete,
  });

  /// IoT template to display
  final IoTDeviceTemplate template;

  /// Callback to delete the template
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            border: Border.all(
              color: state.opacity10,
            ),
            color: K.white5,
          ),
          child: ListTile(
            title: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: CustomText(
                  template.templateName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Wrap(
                spacing: 30,
                runSpacing: 10,
                children: [
                  _HelperTextWidget(
                    text:
                        'Published ${HelperFunctions.getHowLongAgoFromDateTime(template.createdOn)}',
                  ),
                  _HelperTextWidget(
                    text:
                        'Updated ${HelperFunctions.getHowLongAgoFromDateTime(template.lastUpdatedOn)}',
                  ),
                ],
              ),
            ),
            trailing: CustomPopupButton(
              items: [
                CustomPopupMenuItem(
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    context.goNamed(
                      AppRoutes.editIotTemplateRoute.name,
                      extra: {
                        'template': template,
                      },
                    );
                  },
                ),
                CustomPopupMenuItem(
                  onTap: onDelete,
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HelperTextWidget extends StatelessWidget {
  /// Creates a helper text widget
  const _HelperTextWidget({required this.text});

  /// The text of the helper text
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomSvg(
          svgPath: 'assets/icons/calendar_today.svg',
          size: 16,
        ),
        const SizedBox(width: 8),
        CustomText(
          text,
          style: const TextStyle(fontSize: 12),
          opacity: OpacityColors.op40,
        ),
      ],
    );
  }
}
