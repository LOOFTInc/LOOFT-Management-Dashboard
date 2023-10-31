import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/iot_device.dart';
import 'package:management_dashboard/data/models/classes/iot_device_template.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/data/models/functions/chart_functions.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/blocs/iot_devices_list/iot_devices_list_bloc.dart';
import 'package:management_dashboard/logic/cubits/global_observables/global_observables_cubit.dart';
import 'package:management_dashboard/logic/cubits/iot_device_templates/iot_device_templates_cubit.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/packages/simple_time_range_picker/simple_time_range_picker.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/widgets/iot_device_historical_data_graph_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_container.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_icon_button.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_popup_button.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_switch_button.dart';
import 'package:management_dashboard/presentation/widgets/custom_check_box.dart';
import 'package:management_dashboard/presentation/widgets/custom_divider.dart';
import 'package:management_dashboard/presentation/widgets/custom_popup_menu_item.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class IoTDeviceTimelineDataGraphContainer extends StatefulWidget {
  /// A widget to display the timeline data graph for an IoT device
  const IoTDeviceTimelineDataGraphContainer({
    super.key,
    required this.device,
    required this.stopScroll,
    required this.resumeScroll,
  });

  /// IoT Device to display the timeline data graph for
  final IoTDevice device;

  /// Callback to stop the scroll
  final VoidCallback stopScroll;

  /// Callback to resume the scroll
  final VoidCallback resumeScroll;

  @override
  State<IoTDeviceTimelineDataGraphContainer> createState() =>
      _IoTDeviceTimelineDataGraphContainerState();
}

class _IoTDeviceTimelineDataGraphContainerState
    extends State<IoTDeviceTimelineDataGraphContainer> {
  /// Selected Date Range for the data of the selected Device
  DateTime now = DateTime.now();
  late final Rx<DateTimeRange> selectedDateRange;

  /// Loading Data
  RxBool loadingData = false.obs;

  /// Allow Zoom on Graph 1
  RxBool graph1Zoom = false.obs;

  /// Allow Zoom on Graph 2
  RxBool graph2Zoom = false.obs;

  @override
  void initState() {
    super.initState();

    if (widget.device.historicalData?.dateRange != null) {
      selectedDateRange = Rx<DateTimeRange>(
        widget.device.historicalData!.dateRange,
      );
    } else {
      selectedDateRange = Rx<DateTimeRange>(
        DateTimeRange(start: now.subtract(const Duration(days: 1)), end: now),
      );
    }

    if (widget.device.historicalData == null) {
      loadingData.value = true;
      BlocProvider.of<IoTDevicesListBloc>(context)
          .updateHistoricalDataForDevice(
        deviceID: widget.device.deviceID,
        dateRange: selectedDateRange.value,
      )
          .then((value) {
        if (value != null) {
          K.showToast(message: value);
        }

        loadingData.value = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const double iconSize = 24;

    return DashboardResponsiveContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                'Timeline Data',
                style: K.headingStyleDashboard,
              ),
              Obx(
                () => _HelperSelectedTimeText(
                  range: selectedDateRange.value,
                ),
              ),
              Flexible(
                child: Wrap(
                  alignment: WrapAlignment.end,
                  children: [
                    Obx(
                      () => _HelperSelectableIconButton(
                        tooltip:
                            'Toggles Graph Zoom (Scroll over the graph to zoom)',
                        icon: const CustomSvg(
                          svgPath: 'assets/icons/zoom.svg',
                          size: iconSize,
                        ),
                        isSelected: graph1Zoom.value,
                        onPressed: () {
                          graph1Zoom.value = !graph1Zoom.value;
                        },
                      ),
                    ),
                    CustomIconButton(
                      tooltip: 'Refresh Data',
                      onPressed: () async {
                        String? error =
                            await BlocProvider.of<IoTDevicesListBloc>(context)
                                .updateHistoricalDataForDevice(
                          deviceID: widget.device.deviceID,
                          dateRange: selectedDateRange.value,
                        );

                        if (error != null) {
                          K.showToast(message: error);
                        }
                      },
                      icon: const CustomSvg(
                        svgPath: 'assets/icons/refresh.svg',
                        size: iconSize,
                      ),
                    ),
                    IconButton(
                      tooltip:
                          'Download Only Selected Variables Data in the current time range',
                      onPressed: () {
                        ChartFunctions.downloadSelectedMetricsData(
                          device: widget.device,
                          template:
                              BlocProvider.of<IoTDeviceTemplatesCubit>(context)
                                  .getTemplateOrDefault(
                                      widget.device.deviceTemplateID),
                          selectedMetrics: widget.device.selectedMetrics,
                        );
                      },
                      icon: const CustomSvg(
                        svgPath: 'assets/icons/download.svg',
                        size: iconSize,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Download All Data in the current time range',
                      onPressed: () {
                        ChartFunctions.downloadAllData(
                          device: widget.device,
                          template:
                              BlocProvider.of<IoTDeviceTemplatesCubit>(context)
                                  .getTemplateOrDefault(
                                      widget.device.deviceTemplateID),
                        );
                      },
                      icon: const CustomSvg(
                        svgPath: 'assets/icons/bucket_download.svg',
                        size: iconSize,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Select Date Range',
                      onPressed: () async {
                        PickerDateRange? newValue = await showDialog(
                          context: context,
                          builder: (context) {
                            return PointerInterceptor(
                              child: BlocBuilder<ThemeCubit, ThemeState>(
                                builder: (context, state) {
                                  return Container(
                                    height: 420,
                                    width: 320,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: state.reverseOpacity100,
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: SfDateRangePickerTheme(
                                      data: SfDateRangePickerThemeData(
                                        startRangeSelectionColor: K.primaryBlue,
                                        endRangeSelectionColor: K.primaryBlue,
                                        rangeSelectionColor:
                                            K.primaryBlue.withOpacity(0.2),
                                        todayHighlightColor: K.primaryBlue,
                                      ),
                                      child: SfDateRangePicker(
                                        selectionMode:
                                            DateRangePickerSelectionMode.range,
                                        showActionButtons: true,
                                        onCancel: () {
                                          Navigator.pop(context);
                                        },
                                        onSubmit: (value) {
                                          Navigator.pop(context, value);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );

                        if (newValue == null) {
                          return;
                        }

                        DateTimeRange newRange = DateTimeRange(
                          start: newValue.startDate!,
                          end: newValue.endDate!.copyWith(
                            hour: 23,
                            minute: 59,
                            second: 59,
                          ),
                        );

                        // ignore: use_build_context_synchronously
                        TimeRangePicker.show(
                          context: context,
                          startTime: TimeOfDay(
                            hour: newRange.start.hour,
                            minute: newRange.start.minute,
                          ),
                          endTime: TimeOfDay(
                            hour: newRange.end.hour,
                            minute: newRange.end.minute,
                          ),
                          onSubmitted: (TimeRangeValue value) {
                            selectedDateRange.value = DateTimeRange(
                              start: newRange.start.copyWith(
                                hour: value.startTime!.hour,
                                minute: value.startTime!.minute,
                              ),
                              end: newRange.end.copyWith(
                                hour: value.endTime!.hour,
                                minute: value.endTime!.minute,
                              ),
                            );
                          },
                        );
                      },
                      icon: const CustomSvg(
                        svgPath: 'assets/icons/calendar_today.svg',
                        size: iconSize,
                      ),
                    ),
                    _HelperVariableSelectionButton(
                      device: widget.device,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 350,
            child: Obx(
              () => loadingData.value
                  ? const Center(child: CircularProgressIndicator())
                  : IoTDeviceHistoricalDataGraphWidget(
                      device: widget.device,
                      stopScroll: widget.stopScroll,
                      resumeScroll: widget.resumeScroll,
                      isGraphZoomEnabled: graph1Zoom.value,
                    ),
            ),
          ),
          const CustomDivider(
            opacityColor: OpacityColors.op10,
            height: 30,
            indent: 15,
            endIndent: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(
                () => _HelperSelectableIconButton(
                  tooltip: 'Toggles Graph Zoom (Scroll over the graph to zoom)',
                  icon: const CustomSvg(
                    svgPath: 'assets/icons/zoom.svg',
                    size: iconSize,
                  ),
                  isSelected: graph2Zoom.value,
                  onPressed: () {
                    graph2Zoom.value = !graph2Zoom.value;
                  },
                ),
              ),
              IconButton(
                tooltip:
                    'Download Only Selected Variables Data in the current time range',
                onPressed: () {
                  ChartFunctions.downloadSelectedMetricsData(
                    device: widget.device,
                    template: BlocProvider.of<IoTDeviceTemplatesCubit>(context)
                        .getTemplateOrDefault(widget.device.deviceTemplateID),
                    selectedMetrics: widget.device.selectedMetrics2,
                  );
                },
                icon: const CustomSvg(
                  svgPath: 'assets/icons/download.svg',
                  size: iconSize,
                ),
              ),
              _HelperVariableSelectionButton(
                device: widget.device,
                isForSecondGraph: true,
              ),
            ],
          ),
          SizedBox(
            height: 350,
            child: Obx(
              () => loadingData.value
                  ? const Center(child: CircularProgressIndicator())
                  : IoTDeviceHistoricalDataGraphWidget(
                      device: widget.device,
                      stopScroll: widget.stopScroll,
                      resumeScroll: widget.resumeScroll,
                      isSecondGraph: true,
                      isGraphZoomEnabled: graph2Zoom.value,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HelperVariableSelectionButton extends StatelessWidget {
  /// A helper widget to display the variable selection button
  const _HelperVariableSelectionButton({
    required this.device,
    this.isForSecondGraph = false,
  });

  /// IoT Device to display the variable selection button for
  final IoTDevice device;

  /// Whether this is for the second graph
  final bool isForSecondGraph;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IoTDeviceTemplatesCubit, IoTDeviceTemplatesState>(
      builder: (context, templatesState) {
        IoTDeviceTemplate? deviceTemplate =
            BlocProvider.of<IoTDeviceTemplatesCubit>(context)
                .getTemplateOrDefault(device.deviceTemplateID);

        if (deviceTemplate == null) {
          return const _HelperErrorPopupButton(
            error: 'Default Template not found',
          );
        }

        return BlocConsumer<IoTDevicesListBloc, IoTDevicesListState>(
          listener: (context, devicesListState) {
            try {
              IoTDevice currentDevice = devicesListState.devices
                  .firstWhere((element) => element.deviceID == device.deviceID);

              List<String>? selectedMetrics = isForSecondGraph
                  ? currentDevice.selectedMetrics2
                  : currentDevice.selectedMetrics;

              if (selectedMetrics == null &&
                  (currentDevice.historicalData?.availableMetrics.isNotEmpty ??
                      false)) {
                BlocProvider.of<IoTDevicesListBloc>(context).toggleDeviceMetric(
                  deviceID: device.deviceID,
                  metric: deviceTemplate.metrics
                      .where((element) =>
                          currentDevice.historicalData
                              ?.availableMetrics[element.variableName] ??
                          false)
                      .firstOrNull!
                      .variableName,
                  isSecondGraph: isForSecondGraph,
                );
              }
            } catch (e) {}
          },
          builder: (context, devicesListState) {
            IoTDevice currentDevice;

            try {
              currentDevice = devicesListState.devices
                  .firstWhere((element) => element.deviceID == device.deviceID);
            } catch (e) {
              return const _HelperErrorPopupButton(
                error: 'Device Not Found',
              );
            }

            if (currentDevice.historicalData == null) {
              return const _HelperErrorPopupButton(
                error: 'No Data Available',
              );
            }

            return CustomPopupButton(
              items: [
                const CustomPopupMenuItem(
                  enabled: false,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: CustomText(
                      'Select Variables',
                      opacity: OpacityColors.op100,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                ...deviceTemplate.metrics
                    .where((element) =>
                        currentDevice.historicalData
                            ?.availableMetrics[element.variableName] ??
                        false)
                    .map(
                      (metric) => CustomPopupMenuItem(
                        enabled: false,
                        child: _HelperCheckboxPopupMenuItem(
                          text: metric.getFullName(),
                          initialValue: (isForSecondGraph
                                      ? currentDevice.selectedMetrics2
                                      : currentDevice.selectedMetrics)
                                  ?.contains(metric.variableName) ??
                              false,
                          onChanged: () {
                            return BlocProvider.of<IoTDevicesListBloc>(context)
                                .toggleDeviceMetric(
                              deviceID: device.deviceID,
                              metric: metric.variableName,
                              isSecondGraph: isForSecondGraph,
                            );
                          },
                        ),
                      ),
                    )
                    .toList(),
                const PopupMenuItem(
                  enabled: false,
                  height: 1,
                  child: CustomDivider(
                    opacityColor: OpacityColors.op5,
                  ),
                ),
                CustomPopupMenuItem(
                  enabled: false,
                  child: BlocBuilder<GlobalObservablesCubit,
                      GlobalObservablesState>(
                    builder: (context, state) {
                      return _HelperTogglePopupMenuItem(
                        text: 'Day Night Gradient',
                        value: state.showDayNightGradient,
                        onChanged: (val) {
                          BlocProvider.of<GlobalObservablesCubit>(context)
                              .toggleDayNightGradient();
                        },
                      );
                    },
                  ),
                ),
                CustomPopupMenuItem(
                  enabled: false,
                  child: BlocBuilder<GlobalObservablesCubit,
                      GlobalObservablesState>(
                    builder: (context, state) {
                      return _HelperTogglePopupMenuItem(
                        text: 'Highlight Difference',
                        value: state.shouldHighlightGraphDifference,
                        onChanged: (val) {
                          BlocProvider.of<GlobalObservablesCubit>(context)
                              .toggleGraphDifferenceHighlight();
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _HelperErrorPopupButton extends StatelessWidget {
  /// A helper widget to display the error popup button
  const _HelperErrorPopupButton({required this.error});

  /// Error to be displayed
  final String error;

  @override
  Widget build(BuildContext context) {
    return CustomPopupButton(
      items: [
        CustomPopupMenuItem(
          enabled: false,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: CustomText(
              error,
              opacity: OpacityColors.op100,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}

class _HelperCheckboxPopupMenuItem extends StatefulWidget {
  /// A helper widget to display the checkbox popup menu item
  const _HelperCheckboxPopupMenuItem({
    required this.text,
    this.initialValue = false,
    this.onChanged,
  });

  /// Text to be displayed
  final String text;

  /// Initial value of the checkbox
  final bool initialValue;

  /// Callback when the value of the checkbox changes
  final bool Function()? onChanged;

  @override
  State<_HelperCheckboxPopupMenuItem> createState() =>
      _HelperCheckboxPopupMenuItemState();
}

class _HelperCheckboxPopupMenuItemState
    extends State<_HelperCheckboxPopupMenuItem> {
  late bool value = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCheckBox(
            value: value,
            onChanged: (val) {
              setState(() {
                value = widget.onChanged?.call() ?? false;
              });
            }),
        const SizedBox(width: 8),
        CustomText(
          widget.text,
          opacity: OpacityColors.op100,
        ),
      ],
    );
  }
}

class _HelperTogglePopupMenuItem extends StatefulWidget {
  /// A helper widget to display the toggle popup menu item
  const _HelperTogglePopupMenuItem({
    required this.text,
    required this.value,
    required this.onChanged,
  });

  /// Text to be displayed
  final String text;

  /// Initial value of the toggle
  final bool value;

  /// Callback when the value of the toggle changes
  final Function(bool) onChanged;

  @override
  State<_HelperTogglePopupMenuItem> createState() =>
      _HelperTogglePopupMenuItemState();
}

class _HelperTogglePopupMenuItemState
    extends State<_HelperTogglePopupMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(width: 8),
            const CustomSvg(svgPath: 'assets/icons/chart_line.svg'),
            const SizedBox(width: 12),
            CustomText(
              widget.text,
              opacity: OpacityColors.op100,
            ),
            const SizedBox(width: 15),
          ],
        ),
        Theme(
          data: Theme.of(context).copyWith(
            useMaterial3: false,
          ),
          child: CustomSwitchButton(
            selected: widget.value,
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}

class _HelperSelectedTimeText extends StatelessWidget {
  /// A widget to display the selected time text
  const _HelperSelectedTimeText({required this.range});

  final DateTimeRange range;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.sizeOf(context).width > 1000) {
      return CustomText(
        'Selected Time: ${HelperFunctions.getFormattedDate(range.start)} - ${HelperFunctions.getFormattedDate(range.end)}',
      );
    }

    return const SizedBox();
  }
}

class _HelperSelectableIconButton extends StatelessWidget {
  /// A helper widget to display the selectable icon button
  const _HelperSelectableIconButton({
    this.isSelected = false,
    this.onPressed,
    required this.icon,
    this.tooltip,
  });

  /// Icon to be displayed
  final Widget icon;

  /// Whether the button is selected
  final bool isSelected;

  /// Callback when the button is pressed
  final VoidCallback? onPressed;

  /// Tooltip for the button
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return IconButton(
          tooltip: tooltip,
          icon: icon,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              isSelected ? state.opacity10 : null,
            ),
          ),
          onPressed: onPressed,
        );
      },
    );
  }
}
