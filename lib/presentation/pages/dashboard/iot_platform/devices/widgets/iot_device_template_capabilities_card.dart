import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/iot_device_template.dart';
import 'package:management_dashboard/data/models/classes/iot_device_template_metric.dart';
import 'package:management_dashboard/data/models/enums/device_template_capability_types.dart';
import 'package:management_dashboard/data/models/enums/device_template_semantic_types.dart';
import 'package:management_dashboard/data/models/enums/device_template_units.dart';
import 'package:management_dashboard/data/models/extensions/string_extensions.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/authentication/widgets/text_link_button.dart';
import 'package:management_dashboard/presentation/pages/dashboard/models/custom_colors.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_drop_down_field.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_form_field_container.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_form_info_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_text_form_field.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_container.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_icon_button.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_text_button.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/dialogs/custom_confirmation_dialog.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';
import 'package:responsive_ui/responsive_ui.dart';

class IoTDeviceTemplateCapabilitiesCard extends StatefulWidget {
  /// A card to show the capabilities of the device template
  const IoTDeviceTemplateCapabilitiesCard({
    super.key,
    required this.template,
    required this.formKeys,
  });

  /// The template to edit
  final IoTDeviceTemplate template;

  /// The form keys List
  final List<GlobalKey<FormBuilderState>> formKeys;

  @override
  State<IoTDeviceTemplateCapabilitiesCard> createState() =>
      _IoTDeviceTemplateCapabilitiesCardState();
}

class _IoTDeviceTemplateCapabilitiesCardState
    extends State<IoTDeviceTemplateCapabilitiesCard> {
  late RxInt metricsCount = widget.template.metrics.length.obs;

  late final List<IoTDeviceTemplateMetric> alreadySavedMetrics =
      List.from(widget.template.metrics);

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.template.metrics.length; i++) {
      widget.formKeys.add(GlobalKey<FormBuilderState>());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DashboardResponsiveContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                'Capabilities',
                style: K.headingStyleDashboard,
              ),
              Gap16(),
              DashboardFormInfoCard(
                leading: CustomSvg(
                  svgPath: 'assets/icons/warning_circle.svg',
                ),
                headingText: 'Add capabilities specific to your Devices',
                padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
              ),
              Gap16(),
            ],
          ),
          Obx(
            () => ListView.separated(
              shrinkWrap: true,
              itemCount: metricsCount.value,
              itemBuilder: (context, index) {
                return _HelperAddCapabilityWidget(
                  metric: widget.template.metrics[index],
                  formKey: widget.formKeys[index],
                  isAlreadySaved: alreadySavedMetrics
                      .contains(widget.template.metrics[index]),
                  onDeletePressed: () {
                    widget.template.metrics.removeAt(index);
                    metricsCount.value = widget.template.metrics.length;

                    widget.formKeys.removeAt(index);
                  },
                );
              },
              separatorBuilder: (context, index) => const Gap16(),
            ),
          ),
          Obx(
            () => metricsCount.value > 0 ? const Gap16() : const SizedBox(),
          ),
          CustomTextButton(
            text: 'Add Capability',
            fontSize: 12,
            onPressed: () {
              widget.template.metrics.add(IoTDeviceTemplateMetric(
                displayName: '',
                variableName: '',
                capabilityType: DeviceTemplateCapabilityTypes.values.first,
                semanticType: DeviceTemplateSemanticTypes.values.first,
                unit: DeviceTemplateUnits.values.first,
                color: CustomColors.values.first,
              ));

              metricsCount.value = widget.template.metrics.length;
              widget.formKeys.add(GlobalKey<FormBuilderState>());
            },
          ),
        ],
      ),
    );
  }
}

class _HelperAddCapabilityWidget extends StatefulWidget {
  /// A widget to add a capability
  const _HelperAddCapabilityWidget({
    required this.metric,
    required this.onDeletePressed,
    required this.formKey,
    required this.isAlreadySaved,
  });

  /// The metric to edit
  final IoTDeviceTemplateMetric metric;

  /// The callback when the delete button is pressed
  final VoidCallback onDeletePressed;

  /// The form key
  final GlobalKey<FormBuilderState> formKey;

  final bool isAlreadySaved;

  @override
  State<_HelperAddCapabilityWidget> createState() =>
      _HelperAddCapabilityWidgetState();
}

class _HelperAddCapabilityWidgetState
    extends State<_HelperAddCapabilityWidget> {
  /// The expandable controllers
  final ExpandableController expandableControllerOutside =
      ExpandableController();
  final ExpandableController expandableControllerInside =
      ExpandableController();

  @override
  Widget build(BuildContext context) {
    Widget child = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ExpandablePanel(
            controller: expandableControllerInside,
            theme: const ExpandableThemeData(
              hasIcon: false,
              tapHeaderToExpand: false,
              tapBodyToExpand: false,
              tapBodyToCollapse: false,
            ),
            header: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HelperResponsiveRow(
                  children: [
                    DashboardTextFormField(
                      name: 'displayName',
                      hint: 'Display Name',
                      label: 'Display Name',
                      initialValue: widget.metric.displayName,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      onChanged: (val) {
                        if (val != null) {
                          widget.metric.displayName = val;
                        }
                      },
                    ),
                    DashboardTextFormField(
                      name: 'variableName',
                      hint: 'Variable Name',
                      label: 'Variable Name',
                      initialValue: widget.metric.variableName,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      onChanged: (val) {
                        if (val != null) {
                          widget.metric.variableName = val;
                        }
                      },
                    ),
                    DashboardDropDownField(
                      name: 'capabilityType',
                      label: 'Capability Type',
                      initialValue: DeviceTemplateCapabilityTypes.values.first,
                      onChanged: (val) {
                        if (val != null) {
                          widget.metric.capabilityType = val;
                        }
                      },
                      widgetItems: DeviceTemplateCapabilityTypes.values
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.name.capitalizedCamelCase,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    DashboardDropDownField(
                      name: 'semanticType',
                      label: 'Semantic Type',
                      initialValue: widget.metric.semanticType,
                      onChanged: (val) {
                        if (val != null) {
                          widget.metric.semanticType = val;
                        }
                      },
                      widgetItems: DeviceTemplateSemanticTypes.values
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.name.capitalizedCamelCase,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: TextLinkButton(
                    text:
                        '${expandableControllerInside.expanded ? 'Less' : 'More'} Details',
                    style: const TextStyle(color: Colors.red),
                    onPressed: () {
                      setState(() {
                        expandableControllerInside.toggle();
                      });
                    },
                  ),
                ),
              ],
            ),
            expanded: Column(
              children: [
                const Gap16(changeForMobile: false),
                _HelperResponsiveRow(
                  children: [
                    DashboardTextFormField(
                      name: 'minValue',
                      hint: '25',
                      label: 'Min Value',
                      initialValue: widget.metric.minValue?.toString(),
                      onChanged: (val) {
                        try {
                          if (val != null) {
                            widget.metric.minValue = double.parse(val);
                          }
                        } catch (e) {
                          K.showToast(message: 'Only numbers are allowed');
                        }
                      },
                    ),
                    DashboardTextFormField(
                      name: 'maxValue',
                      hint: '85',
                      label: 'Max Value',
                      initialValue: widget.metric.maxValue?.toString(),
                      onChanged: (val) {
                        try {
                          if (val != null) {
                            widget.metric.maxValue = double.parse(val);
                          }
                        } catch (e) {
                          K.showToast(message: 'Only numbers are allowed');
                        }
                      },
                    ),
                    DashboardDropDownField(
                      name: 'unit',
                      label: 'Unit',
                      initialValue: widget.metric.unit,
                      onChanged: (val) {
                        if (val != null) {
                          widget.metric.unit = val;
                        }
                      },
                      widgetItems: DeviceTemplateUnits.values
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
                    ),
                    DashboardTextFormField(
                      name: 'displayUnit',
                      hint: '°C',
                      label: 'Display Unit',
                      initialValue: widget.metric.displayUnit,
                      onChanged: (val) {
                        if (val != null) {
                          widget.metric.displayUnit = val;
                        }
                      },
                    ),
                  ],
                ),
                const Gap16(changeForMobile: false),
                _HelperResponsiveRow(
                  children: [
                    DashboardTextFormField(
                      name: 'description',
                      label: 'Description',
                      hint: 'Inside Temperature',
                      initialValue: widget.metric.description,
                      onChanged: (val) {
                        if (val != null) {
                          widget.metric.description = val;
                        }
                      },
                    ),
                    DashboardTextFormField(
                      name: 'label',
                      hint: 'Indoor',
                      label: 'Label',
                      initialValue: widget.metric.label,
                      onChanged: (val) {
                        if (val != null) {
                          widget.metric.label = val;
                        }
                      },
                    ),
                    _HelperColorDropDown(
                      metric: widget.metric,
                      name: 'color',
                      initialValue: widget.metric.color,
                    ),
                    DashboardDropDownField(
                      name: 'showInRealtime',
                      label: 'Show in Realtime data',
                      initialValue: widget.metric.showInRealtime,
                      onChanged: (val) {
                        if (val != null) {
                          widget.metric.showInRealtime = val;
                        }
                      },
                      widgetItems: const [
                        DropdownMenuItem(
                          value: true,
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: false,
                          child: Text(
                            'No',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            collapsed: const SizedBox(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: CustomIconButton(
            icon: const Icon(
              Icons.close,
              size: 20,
              color: Colors.red,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CustomConfirmationDialog(
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  onConfirm: () {
                    widget.onDeletePressed.call();
                    Navigator.pop(context);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return FormBuilder(
          key: widget.formKey,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: state.themeMode == ThemeMode.dark
                  ? K.white5
                  : K.purpleE5ECF6.withOpacity(0.5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Builder(builder: (context) {
              if (widget.isAlreadySaved) {
                child = ExpandablePanel(
                  controller: expandableControllerOutside,
                  theme: const ExpandableThemeData(
                    hasIcon: false,
                    tapHeaderToExpand: false,
                    tapBodyToExpand: false,
                    tapBodyToCollapse: false,
                  ),
                  header: Padding(
                    padding: EdgeInsets.fromLTRB(
                        8, 0, 8, expandableControllerOutside.expanded ? 8 : 0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onTap: () {
                        setState(() {
                          expandableControllerOutside.toggle();
                        });
                      },
                      title: CustomText(
                        '${widget.metric.label == null ? '' : '${widget.metric.label} '}${widget.metric.displayName}',
                        selectable: false,
                      ),
                      trailing: Icon(
                        expandableControllerOutside.expanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                      ),
                    ),
                  ),
                  collapsed: const SizedBox(),
                  expanded: child,
                );
              }

              return child;
            }),
          ),
        );
      },
    );
  }
}

class _HelperResponsiveRow extends StatelessWidget {
  /// A responsive row
  const _HelperResponsiveRow({
    required this.children,
  });

  /// The children widgets
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    assert(children.length == 4);

    return Responsive(
      runSpacing: 16,
      children: children
          .map(
            (e) => Div(
              divison: const Division(
                colS: 12,
                colM: 6,
                colL: 3,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: e,
              ),
            ),
          )
          .toList(),
    );
  }
}

class _HelperColorDropDown extends StatefulWidget {
  /// A dropdown to select the color
  const _HelperColorDropDown({
    required this.metric,
    required this.name,
    required this.initialValue,
  });

  /// The name of the field
  final String name;

  /// The metric to edit
  final IoTDeviceTemplateMetric metric;

  /// The initial value of the dropdown
  final CustomColors initialValue;

  @override
  State<_HelperColorDropDown> createState() => _HelperColorDropDownState();
}

class _HelperColorDropDownState extends State<_HelperColorDropDown> {
  /// The focus node of the text field
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return DashboardFormFieldContainer(
          focusNode: _focusNode,
          label: 'Color',
          lessPadding: true,
          formField: FormBuilderDropdown<CustomColors>(
            name: widget.name,
            style: TextStyle(fontSize: 14, color: state.opacity100),
            initialValue: widget.initialValue,
            borderRadius: BorderRadius.circular(8),
            icon: const CustomSvg(
              svgPath: 'assets/icons/drop_down.svg',
            ),
            items: CustomColors.values
                .map(
                  (e) => DropdownMenuItem<CustomColors>(
                    value: e,
                    child: Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: e.color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            e.name.capitalizedCamelCase,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            focusNode: _focusNode,
            focusColor: Colors.transparent,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            dropdownColor: state.reverseOpacity100,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            onChanged: (val) {
              if (val != null) {
                widget.metric.color = val;
              }
            },
          ),
        );
      },
    );
  }
}
