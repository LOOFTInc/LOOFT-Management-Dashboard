import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/iot_device.dart';
import 'package:management_dashboard/data/models/classes/iot_device_historical_chart_data.dart';
import 'package:management_dashboard/data/models/classes/iot_device_template.dart';
import 'package:management_dashboard/data/models/classes/iot_device_template_metric.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/data/models/functions/chart_functions.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/blocs/iot_devices_list/iot_devices_list_bloc.dart';
import 'package:management_dashboard/logic/cubits/global_observables/global_observables_cubit.dart';
import 'package:management_dashboard/logic/cubits/iot_device_templates/iot_device_templates_cubit.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/models/custom_colors.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IoTDeviceHistoricalDataGraphWidget extends StatelessWidget {
  /// Graph to show the historical data graph for a device
  const IoTDeviceHistoricalDataGraphWidget({
    super.key,
    required this.device,
    required this.stopScroll,
    required this.resumeScroll,
    this.isSecondGraph = false,
    this.isGraphZoomEnabled = false,
  });

  /// Device for which the graph is to be shown
  final IoTDevice device;

  /// Callback to stop the scroll
  final VoidCallback stopScroll;

  /// Callback to resume the scroll
  final VoidCallback resumeScroll;

  /// Whether this is the second graph
  final bool isSecondGraph;

  /// Whether the graph zoom is enabled
  final bool isGraphZoomEnabled;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IoTDeviceTemplatesCubit, IoTDeviceTemplatesState>(
      builder: (context, templatesState) {
        IoTDeviceTemplate? deviceTemplate =
            BlocProvider.of<IoTDeviceTemplatesCubit>(context)
                .getTemplateOrDefault(device.deviceTemplateID);

        if (deviceTemplate == null) {
          return const Center(
            child: CustomText(
              'Default Template not found',
            ),
          );
        }

        return BlocBuilder<IoTDevicesListBloc, IoTDevicesListState>(
          builder: (context, devicesListState) {
            IoTDevice currentDevice;

            try {
              currentDevice = devicesListState.devices
                  .firstWhere((element) => element.deviceID == device.deviceID);
            } catch (e) {
              return const Center(
                child: CustomText(
                  'Device not Found',
                ),
              );
            }

            if (currentDevice.historicalData == null) {
              return const Center(
                child: CustomText(
                  'Kindly fetch some data to show here',
                ),
              );
            }

            if (currentDevice.historicalData!.rawData.isEmpty) {
              return const Center(
                child: CustomText(
                  'No Data available in the given time range',
                ),
              );
            }

            final List<String>? selectedMetricStrings = isSecondGraph
                ? currentDevice.selectedMetrics2
                : currentDevice.selectedMetrics;

            if (selectedMetricStrings == null ||
                selectedMetricStrings.isEmpty) {
              return const Center(
                child: CustomText(
                  'Please Select some variables to show data',
                ),
              );
            }

            // Get the selected metrics from the default template
            final List<IoTDeviceTemplateMetric> selectedMetrics = deviceTemplate
                .metrics
                .where((element) =>
                    selectedMetricStrings.contains(element.variableName))
                .toList();

            // Get the data points for the day/night indicators
            final List<IoTDeviceHistoricalChartData> dayNightIndicatorData =
                ChartFunctions.getDataPointsForDayNightIndicators(
                    currentDevice.historicalData!.averagedData);

            // Get the end values data for the max/min/average lines
            List<IoTDeviceHistoricalChartData> endValuesData = [
              IoTDeviceHistoricalChartData(
                  x: currentDevice.historicalData!.averagedData.first.x),
              IoTDeviceHistoricalChartData(
                  x: currentDevice.historicalData!.averagedData.last.x),
            ];

            // Get the max value for the selected metric
            double? maxValue;
            try {
              maxValue = deviceTemplate.metrics
                  .firstWhere((element) =>
                      element.variableName == selectedMetricStrings.first)
                  .maxValue;
            } catch (e) {}

            // Get the min value for the selected metric
            double? minValue;
            try {
              minValue = deviceTemplate.metrics
                  .firstWhere((element) =>
                      element.variableName == selectedMetricStrings.first)
                  .minValue;
            } catch (e) {}

            return BlocBuilder<GlobalObservablesCubit, GlobalObservablesState>(
              builder: (context, globalObsState) {
                // Check if the day/night indicators should be shown
                final bool shouldShowDayNightIndicators =
                    globalObsState.showDayNightGradient &&
                        currentDevice.historicalData!.averagedData.last.x
                                .difference(currentDevice
                                    .historicalData!.averagedData.first.x)
                                .inDays <
                            2 &&
                        selectedMetricStrings.isNotEmpty &&
                        selectedMetricStrings.length < 5;

                // Check if the max/min/average lines should be shown
                bool showMaxMinAverageLines =
                    selectedMetricStrings.length == 1 &&
                        currentDevice.historicalData!.averagedData.length !=
                            currentDevice.historicalData!.chartData.length;

                double graphMax = currentDevice.historicalData!.averagedData
                    .map((e) => e.getMaxValueForGivenSensors(
                        selectedMetrics: selectedMetricStrings))
                    .reduce(max);
                graphMax =
                    max(graphMax, maxValue ?? double.negativeInfinity) * 1.3;

                return BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, themeState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'Graph ${isSecondGraph ? '2' : '1'}',
                          opacity: OpacityColors.op40,
                        ),
                        MouseRegion(
                          onEnter: (_) {
                            if (isGraphZoomEnabled) {
                              stopScroll();
                            }
                          },
                          onExit: (_) {
                            resumeScroll();
                          },
                          child: SfCartesianChart(
                            zoomPanBehavior: ZoomPanBehavior(
                              enablePanning: true,
                              enableMouseWheelZooming: isGraphZoomEnabled,
                              zoomMode: ZoomMode.x,
                            ),
                            legend: const Legend(
                              isVisible: true,
                              position: LegendPosition.top,
                              alignment: ChartAlignment.far,
                              overflowMode: LegendItemOverflowMode.scroll,
                            ),
                            primaryXAxis: DateTimeAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                              minorGridLines: const MinorGridLines(width: 0),
                              majorTickLines: const MajorTickLines(width: 0),
                              minorTickLines: const MinorTickLines(width: 0),
                              dateFormat: DateFormat('d/M\n').add_jm(),
                              plotBands: shouldShowDayNightIndicators
                                  ? dayNightIndicatorData
                                      .map((e) => PlotBand(
                                            isVisible: true,
                                            start: e.x,
                                            end: e.x,
                                            borderWidth: 1,
                                            opacity: 0.5,
                                            borderColor: themeState.themeMode ==
                                                    ThemeMode.dark
                                                ? Colors.white
                                                : K.grey3C3A3A,
                                            dashArray: const [5, 5],
                                          ))
                                      .toList()
                                  : null,
                            ),
                            primaryYAxis: NumericAxis(
                              decimalPlaces: 1,
                              axisLine: const AxisLine(width: 0),
                              minorGridLines: const MinorGridLines(width: 0),
                              majorTickLines: const MajorTickLines(width: 0),
                              minorTickLines: const MinorTickLines(width: 0),
                              maximum: shouldShowDayNightIndicators
                                  ? graphMax
                                  : null,
                            ),
                            tooltipBehavior: TooltipBehavior(
                              enable: true,
                              builder: (dynamic data,
                                  dynamic point,
                                  dynamic series,
                                  int pointIndex,
                                  int seriesIndex) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        DateFormat('d MMM y,')
                                            .add_jm()
                                            .format(point.x),
                                        opacity: OpacityColors.rop100,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              width: 0.5,
                                              color:
                                                  themeState.reverseOpacity100,
                                            ),
                                          ),
                                        ),
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 2),
                                              child: Icon(
                                                Icons.circle_rounded,
                                                color: series.color,
                                                size: 12,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            CustomText(
                                              '${series.name}: ${HelperFunctions.getUpToNDecimalPlaces(point.y, 2)}',
                                              opacity: OpacityColors.rop100,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            plotAreaBorderWidth: 0,
                            series: <ChartSeries>[
                              ...selectedMetrics.map(
                                (metric) => SplineSeries<
                                    IoTDeviceHistoricalChartData, DateTime>(
                                  name: metric.getFullName(),
                                  dataSource: currentDevice
                                      .historicalData!.averagedData,
                                  xValueMapper:
                                      (IoTDeviceHistoricalChartData data, _) =>
                                          data.x,
                                  yValueMapper:
                                      (IoTDeviceHistoricalChartData data, _) =>
                                          data.y[metric.variableName],
                                  width: 2,
                                  color: metric.color.color,
                                ),
                              ),
                              if (shouldShowDayNightIndicators) ...[
                                AreaSeries<IoTDeviceHistoricalChartData,
                                    DateTime>(
                                  isVisibleInLegend: false,
                                  enableTooltip: false,
                                  dataSource: currentDevice
                                      .historicalData!.averagedData,
                                  legendIconType: LegendIconType.circle,
                                  xValueMapper:
                                      (IoTDeviceHistoricalChartData data, _) =>
                                          data.x,
                                  yValueMapper:
                                      (IoTDeviceHistoricalChartData data, _) =>
                                          graphMax,
                                  opacity: 0.3,
                                  gradient: ChartFunctions.getGradientFromData(
                                      currentDevice
                                          .historicalData!.averagedData),
                                ),
                                ScatterSeries<IoTDeviceHistoricalChartData,
                                    DateTime>(
                                  isVisibleInLegend: false,
                                  enableTooltip: false,
                                  dataSource: dayNightIndicatorData,
                                  xValueMapper:
                                      (IoTDeviceHistoricalChartData data, _) =>
                                          data.x,
                                  yValueMapper:
                                      (IoTDeviceHistoricalChartData data, _) =>
                                          1,
                                  markerSettings: const MarkerSettings(
                                    width: 0,
                                    height: 0,
                                  ),
                                  dataLabelSettings: DataLabelSettings(
                                    labelAlignment: ChartDataLabelAlignment.top,
                                    isVisible: true,
                                    builder: (dynamic data,
                                        dynamic point,
                                        dynamic series,
                                        int pointIndex,
                                        int seriesIndex) {
                                      return Text(
                                        ChartFunctions
                                            .getDayNightTextFromDateTime(
                                                data.x),
                                        style: TextStyle(
                                          color: themeState.themeMode ==
                                                  ThemeMode.dark
                                              ? Colors.white
                                              : K.grey3C3A3A,
                                          fontSize: 10,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                              if (showMaxMinAverageLines) ...[
                                if (currentDevice
                                        .historicalData!.minOfAveragedData !=
                                    null)
                                  FastLineSeries<IoTDeviceHistoricalChartData,
                                      DateTime>(
                                    name: 'Min',
                                    dataSource: currentDevice
                                        .historicalData!.minOfAveragedData!,
                                    dashArray: <double>[5, 5],
                                    width: 1,
                                    isVisibleInLegend: false,
                                    xValueMapper:
                                        (IoTDeviceHistoricalChartData data,
                                                _) =>
                                            data.x,
                                    yValueMapper:
                                        (IoTDeviceHistoricalChartData data,
                                                _) =>
                                            data.y[selectedMetricStrings.first],
                                    color: Colors.grey,
                                  ),
                                FastLineSeries<IoTDeviceHistoricalChartData,
                                    DateTime>(
                                  name: 'Max',
                                  dataSource: currentDevice
                                      .historicalData!.maxOfAveragedData!,
                                  dashArray: <double>[5, 5],
                                  width: 1,
                                  isVisibleInLegend: false,
                                  xValueMapper:
                                      (IoTDeviceHistoricalChartData data, _) =>
                                          data.x,
                                  yValueMapper:
                                      (IoTDeviceHistoricalChartData data, _) =>
                                          data.y[selectedMetricStrings.first],
                                  color: Colors.grey,
                                ),
                              ],
                              if (globalObsState
                                      .shouldHighlightGraphDifference &&
                                  selectedMetricStrings.length == 1) ...[
                                if (maxValue != null)
                                  FastLineSeries<IoTDeviceHistoricalChartData,
                                      DateTime>(
                                    name: 'Maximum Limit',
                                    dataSource: endValuesData,
                                    dashArray: <double>[5, 5],
                                    width: 1,
                                    isVisibleInLegend: false,
                                    xValueMapper:
                                        (IoTDeviceHistoricalChartData data,
                                                _) =>
                                            data.x,
                                    yValueMapper:
                                        (IoTDeviceHistoricalChartData data,
                                                _) =>
                                            maxValue,
                                    color: Colors.red,
                                  ),
                                if (minValue != null)
                                  FastLineSeries<IoTDeviceHistoricalChartData,
                                      DateTime>(
                                    name: 'Minimum Limit',
                                    dataSource: endValuesData,
                                    dashArray: <double>[5, 5],
                                    width: 1,
                                    isVisibleInLegend: false,
                                    xValueMapper:
                                        (IoTDeviceHistoricalChartData data,
                                                _) =>
                                            data.x,
                                    yValueMapper:
                                        (IoTDeviceHistoricalChartData data,
                                                _) =>
                                            minValue,
                                    color: Colors.green,
                                  ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
