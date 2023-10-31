import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/iot_device.dart';
import 'package:management_dashboard/data/models/classes/iot_device_template.dart';
import 'package:management_dashboard/data/models/classes/iot_device_template_metric.dart';
import 'package:management_dashboard/data/models/enums/device_template_units.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/blocs/iot_devices_list/iot_devices_list_bloc.dart';
import 'package:management_dashboard/logic/cubits/iot_device_templates/iot_device_templates_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/models/custom_colors.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/colored_text_container.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_container.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/responsive_row.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class IoTDeviceRealtimeDataWidget extends StatelessWidget {
  /// A widget to display realtime data for an IoT device
  const IoTDeviceRealtimeDataWidget({
    super.key,
    required this.device,
  });

  /// IoT Device to display the realtime data for
  final IoTDevice device;

  @override
  Widget build(BuildContext context) {
    return DashboardResponsiveContainer(
      scrollable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            'Realtime Data',
            style: K.headingStyleDashboard,
          ),
          const Gap28(changeForMobile: false),
          BlocBuilder<IoTDeviceTemplatesCubit, IoTDeviceTemplatesState>(
            builder: (context, templatesState) {
              IoTDeviceTemplate? deviceTemplate =
                  BlocProvider.of<IoTDeviceTemplatesCubit>(context)
                      .getTemplateOrDefault(device.deviceTemplateID);

              if (deviceTemplate == null) {
                return const SizedBox(
                  height: 230,
                  child: Center(
                      child: CustomText(
                    'Default Template not found',
                  )),
                );
              }

              return BlocBuilder<IoTDevicesListBloc, IoTDevicesListState>(
                builder: (context, listState) {
                  IoTDevice? currentDevice = listState.devices.firstWhere(
                      (element) => element.deviceID == device.deviceID);

                  if (currentDevice.realtimeData == null) {
                    return const Center(child: CustomText('No Data Available'));
                  }

                  List<String> uniqueMetricNames = deviceTemplate.metrics
                      .where((metric) => metric.showInRealtime)
                      .map((metric) => metric.displayName)
                      .toSet()
                      .toList();

                  if (uniqueMetricNames.isEmpty) {
                    return const Center(
                        child: CustomText('No Capabilities Selected'));
                  }

                  return Column(
                    children: uniqueMetricNames.map((metric) {
                      List<IoTDeviceTemplateMetric> metrics = deviceTemplate
                          .metrics
                          .where((element) =>
                              element.displayName == metric &&
                              element.showInRealtime)
                          .toList();

                      return Column(
                        children: [
                          _HelperWidget(
                            metrics: metrics,
                            values: metrics.map((metric) {
                              try {
                                return currentDevice
                                    .realtimeData![metric.variableName];
                              } catch (e) {
                                return null;
                              }
                            }).toList(),
                          ),
                          const Gap16(),
                        ],
                      );
                    }).toList(),
                  );
                },
              );
            },
          ),
          const Gap16(),
        ],
      ),
    );
  }
}

class _HelperWidget extends StatelessWidget {
  /// A helper widget for the realtime data widget
  const _HelperWidget({
    required this.metrics,
    required this.values,
  });

  /// Metric to display
  final List<IoTDeviceTemplateMetric> metrics;

  /// Value of the metric
  final List<dynamic> values;

  @override
  Widget build(BuildContext context) {
    assert(metrics.length == values.length);

    return ResponsiveRow(
      rowCrossAxisAlignment: CrossAxisAlignment.start,
      rightExpanded: true,
      leftWidget: SizedBox(
        width: 200,
        child: Align(
          alignment: Alignment.centerLeft,
          child: CustomText(
            metrics.first.displayName,
            opacity: OpacityColors.op40,
          ),
        ),
      ),
      rightWidget: Wrap(
        spacing: 50,
        runSpacing: 10,
        children: List.generate(metrics.length, (index) {
          IoTDeviceTemplateMetric metric = metrics.elementAt(index);

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (metric.label != null &&
                  (metric.label?.isNotEmpty ?? false)) ...[
                Flexible(
                  child: ColoredTextContainer(
                    textColor: metric.color,
                    text: metric.label ?? '?',
                  ),
                ),
                const SizedBox(width: 20),
              ],
              Flexible(
                child: CustomText(
                  '${HelperFunctions.getUpToNDecimalPlaces(values.elementAt(index), 2)} ${metric.displayUnit ?? metric.unit.symbol}',
                  staticColor: metric.color.color,
                ),
              ),
            ],
          );
        }).toList(),
      ),
      breakWidth: K.mobileSize,
    );
  }
}
