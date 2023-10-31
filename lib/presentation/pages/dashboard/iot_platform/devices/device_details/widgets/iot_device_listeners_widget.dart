import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/iot_device.dart';
import 'package:management_dashboard/data/models/classes/iot_device_listener_data.dart';
import 'package:management_dashboard/data/models/enums/iot_listener_comparison.dart';
import 'package:management_dashboard/logic/blocs/iot_devices_list/iot_devices_list_bloc.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_container.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_icon_button.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_text_button.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/dialogs/custom_confirmation_dialog.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class IoTDeviceListenersWidget extends StatefulWidget {
  /// A widget to display the listeners for an IoT device
  const IoTDeviceListenersWidget({
    super.key,
    required this.device,
  });

  /// IoT Device to show the Listeners for
  final IoTDevice device;

  @override
  State<IoTDeviceListenersWidget> createState() =>
      _IoTDeviceListenersWidgetState();
}

class _IoTDeviceListenersWidgetState extends State<IoTDeviceListenersWidget> {
  /// Whether the listeners are loading
  bool loading = false;

  /// Error message if any
  String? error;

  /// Listener count
  late RxInt listenerCount = (widget.device.listeners?.length ?? 0).obs;

  @override
  void initState() {
    super.initState();

    if (widget.device.listeners == null) {
      loading = true;

      BlocProvider.of<IoTDevicesListBloc>(context)
          .fetchIoTDeviceListeners(device: widget.device)
          .then((value) {
        error = value;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DashboardResponsiveContainer(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  'Listeners',
                  style: K.headingStyleDashboard,
                ),
                const Gap16(isHorizontal: true),
                Wrap(
                  children: [
                    CustomIconButton(
                      onPressed: () async {
                        await BlocProvider.of<IoTDevicesListBloc>(context)
                            .fetchIoTDeviceListeners(device: widget.device)
                            .then((value) {
                          error = value;
                        });
                      },
                      icon: const Icon(
                        Icons.refresh,
                        size: 16,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (widget.device.deviceName == null) {
                          K.showToast(
                              message: 'Please add device details first');
                          return;
                        }

                        if (loading) return;

                        widget.device.listeners?.add(IoTDeviceListenerData(
                          email: '',
                          deviceName:
                              widget.device.deviceName ?? 'Unknown Device',
                          comparison: IoTListenerComparison.equalTo,
                          variableName:
                              widget.device.realtimeData?.keys.first ?? '',
                        ));

                        listenerCount.value++;
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Gap16(),
            BlocBuilder<IoTDevicesListBloc, IoTDevicesListState>(
              builder: (context, state) {
                if (loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (error != null) {
                  return Center(
                    child: CustomText(
                      error!,
                    ),
                  );
                }

                final IoTDevice currentDevice;
                try {
                  currentDevice = state.devices.firstWhere(
                      (element) => element.deviceID == widget.device.deviceID);
                } catch (e) {
                  return const Center(
                    child: CustomText(
                      'Device not found',
                    ),
                  );
                }

                return Obx(() {
                  if (listenerCount.value == 0 &&
                      (currentDevice.listeners == null ||
                          currentDevice.listeners!.isEmpty)) {
                    return const Center(
                      child: CustomText(
                        'No listeners found',
                      ),
                    );
                  }

                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return _HelperListenerWidget(
                        index: index,
                        listenerData: widget.device.listeners![index],
                        device: currentDevice,
                        onCancel: () {
                          widget.device.listeners
                              ?.remove(widget.device.listeners![index]);

                          listenerCount.value--;
                        },
                        onDelete: () {
                          widget.device.listeners
                              ?.remove(widget.device.listeners![index]);

                          listenerCount.value--;
                        },
                      );
                    },
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const Gap16(),
                    itemCount: listenerCount.value,
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HelperListenerWidget extends StatefulWidget {
  /// Helper listener widget
  const _HelperListenerWidget({
    required this.listenerData,
    required this.index,
    required this.device,
    required this.onCancel,
    required this.onDelete,
  });

  /// IoT Device to show the Listener for
  final IoTDeviceListenerData listenerData;

  /// IoT Device to show the Listener for
  final IoTDevice device;

  /// Index of the listener
  final int index;

  /// On cancel callback
  final VoidCallback onCancel;

  /// On delete callback
  final VoidCallback onDelete;

  @override
  State<_HelperListenerWidget> createState() => _HelperListenerWidgetState();
}

class _HelperListenerWidgetState extends State<_HelperListenerWidget> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Wrap(
        runSpacing: 10,
        spacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          CustomText('${widget.index + 1}.'),
          const CustomText('If'),
          SizedBox(
            width: 200,
            child: Builder(builder: (context) {
              String? initialValue;
              if (widget.device.realtimeData?.keys
                      .contains(widget.listenerData.variableName) ??
                  false) {
                initialValue = widget.listenerData.variableName;
              }

              List<String> items =
                  widget.device.realtimeData?.keys.toList() ?? [];
              if (items.isEmpty) {
                items.add('No Items Available');
              }

              return _HelperDropDownWidget(
                name: 'metric${widget.index + 1}',
                enabled: widget.device.realtimeData != null ||
                    widget.device.realtimeData!.isNotEmpty,
                initialValue: initialValue,
                items: items,
                onChanged: (value) {
                  if (value != null) {
                    widget.listenerData.variableName = value;
                  }
                },
              );
            }),
          ),
          const CustomText('is'),
          SizedBox(
            width: 150,
            child: _HelperDropDownWidget(
              name: 'comparison${widget.index + 1}',
              initialValue: widget.listenerData.comparison.displayName,
              items: IoTListenerComparison.values
                  .map((e) => e.displayName)
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  widget.listenerData.comparison =
                      IoTListenerComparison.fromStringDisplayName(value);
                }
              },
            ),
          ),
          SizedBox(
            width: 90,
            child: _HelperTextFieldWidget(
              name: 'value${widget.index + 1}',
              hint: 'Value',
              initialValue: widget.listenerData.threshold?.toString(),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
              ]),
              onChanged: (value) {
                if (value != null) {
                  widget.listenerData.threshold = double.tryParse(value);
                }
              },
            ),
          ),
          const CustomText('email'),
          SizedBox(
            width: 200,
            child: _HelperTextFieldWidget(
              name: 'email${widget.index + 1}',
              hint: 'Email',
              initialValue: widget.listenerData.email,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
              ]),
              onChanged: (value) {
                if (value != null) {
                  widget.listenerData.email = value;
                }
              },
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SizedBox(
                  width: 80,
                  child: CustomTextButton(
                    text: widget.listenerData.listenerID == null
                        ? 'Add'
                        : 'Update',
                    fontSize: 12,
                    textColor: K.white,
                    backgroundColor: K.primaryBlue,
                    onPressed: () async {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        String? error;
                        if (widget.listenerData.listenerID != null) {
                          error =
                              await BlocProvider.of<IoTDevicesListBloc>(context)
                                  .updateIoTDeviceListener(
                            device: widget.device,
                            listener: widget.listenerData,
                          );

                          if (error != null) {
                            K.showToast(message: error);
                            return;
                          } else {
                            K.showToast(
                                message: 'Listener updated successfully');
                          }
                        } else {
                          error =
                              await BlocProvider.of<IoTDevicesListBloc>(context)
                                  .addIoTDeviceListener(
                            device: widget.device,
                            listener: widget.listenerData,
                          );

                          if (error != null) {
                            K.showToast(message: error);
                            return;
                          } else {
                            K.showToast(message: 'Listener added successfully');
                          }
                        }
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 80,
                child: CustomTextButton(
                  text: widget.listenerData.listenerID == null
                      ? 'Cancel'
                      : 'Delete',
                  fontSize: 12,
                  textColor: K.white,
                  backgroundColor: K.redFF4747,
                  onPressed: () async {
                    if (widget.listenerData.listenerID == null) {
                      widget.onCancel();
                      return;
                    } else {
                      showDialog(
                        context: context,
                        builder: (dialogContext) => CustomConfirmationDialog(
                          onCancel: () {
                            Navigator.pop(dialogContext);
                          },
                          onConfirm: () async {
                            String? error =
                                await BlocProvider.of<IoTDevicesListBloc>(
                                        context)
                                    .deleteIoTDeviceListener(
                              device: widget.device,
                              listener: widget.listenerData,
                            );

                            if (error != null) {
                              K.showToast(message: error);
                            } else {
                              widget.onDelete();
                              K.showToast(
                                  message: 'Listener deleted successfully');
                            }

                            Navigator.canPop(dialogContext);
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HelperTextFieldWidget extends StatelessWidget {
  /// Helper email field widget
  const _HelperTextFieldWidget({
    required this.name,
    required this.hint,
    this.initialValue,
    this.validator,
    this.onChanged,
  });

  /// Name of the field
  final String name;

  /// Hint of the field
  final String hint;

  /// Initial value of the field
  final String? initialValue;

  /// The validator of the text field
  final String? Function(String?)? validator;

  /// The onChanged of the text field
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return FormBuilderTextField(
          style: const TextStyle(fontSize: 14),
          name: name,
          initialValue: initialValue,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: state.opacity20,
            ),
            contentPadding: const EdgeInsets.all(16),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(color: state.opacity40),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(color: state.opacity10),
            ),
          ),
          validator: validator,
          onChanged: onChanged,
        );
      },
    );
  }
}

class _HelperDropDownWidget extends StatelessWidget {
  /// Helper Dropdown widget
  const _HelperDropDownWidget({
    required this.name,
    required this.items,
    this.enabled = true,
    this.initialValue,
    this.onChanged,
  });

  /// Name of the field
  final String name;

  /// Items to display in the dropdown
  final List<String> items;

  /// Whether the dropdown is enabled or not
  final bool enabled;

  /// Initial value of the dropdown
  final String? initialValue;

  /// The onChanged of the text field
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return FormBuilderDropdown<String>(
          style: TextStyle(fontSize: 14, color: state.opacity100),
          initialValue: initialValue,
          borderRadius: BorderRadius.circular(8),
          icon: const CustomSvg(
            svgPath: 'assets/icons/drop_down.svg',
          ),
          items: items
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e, overflow: TextOverflow.ellipsis),
                ),
              )
              .toList(),
          focusColor: Colors.transparent,
          enabled: enabled,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          name: name,
          dropdownColor: state.reverseOpacity100,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(color: state.opacity40),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(color: state.opacity10),
            ),
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
          onChanged: onChanged,
        );
      },
    );
  }
}
