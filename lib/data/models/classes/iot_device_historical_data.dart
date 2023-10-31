import 'package:flutter/material.dart';
import 'package:management_dashboard/data/models/classes/iot_device_historical_chart_data.dart';

/// Class for IoT Device Historical Data
class IoTDeviceHistoricalData {
  /// Historical data in Map Form
  List<Map<String, dynamic>> rawData;

  /// Historical data in ChartData form
  late List<IoTDeviceHistoricalChartData> chartData;

  /// Date range of the historical data
  DateTimeRange dateRange;

  /// Available metrics for the selected device
  Map<String, bool> availableMetrics = <String, bool>{};

  /// Stores the averaged data
  late List<IoTDeviceHistoricalChartData> averagedData;

  /// Stores the max values from the averaged data for the selected device
  List<IoTDeviceHistoricalChartData>? minOfAveragedData;

  /// Stores the min values from the averaged data for the selected device
  List<IoTDeviceHistoricalChartData>? maxOfAveragedData;

  IoTDeviceHistoricalData({
    required this.rawData,
    required this.dateRange,
  }) {
    // Populate Chart data from Raw Data
    // Also Filters out the data that is not Numeric
    chartData = [];
    for (Map<String, dynamic> e in rawData) {
      if (e['Time'] == null) {
        continue;
      }

      final DateTime time;
      try {
        time = e['Time'].toDate();
      } catch (e) {
        continue;
      }

      final Map<String, double?> newMap = {};
      e.forEach((key, value) {
        if (key == 'Time') {
          return;
        }

        final double? newValue;
        if (value == null) {
          newValue = null;
        } else {
          try {
            newValue = double.parse(value.toString());
          } catch (e) {
            return;
          }
        }

        newMap[key] = newValue;
        availableMetrics[key] = true;
      });

      chartData.add(IoTDeviceHistoricalChartData(
        x: time,
        y: newMap,
      ));
    }

    // Average the chart Data
    final Duration? durationForAverage = getAverageDurationFromData();
    if (durationForAverage == null) {
      averagedData = chartData;
      return;
    }

    final List<List<IoTDeviceHistoricalChartData>> result =
        averageMinMaxForGivenDuration(
      durationForAverage,
    );

    averagedData = result[1];
    minOfAveragedData = result[0];
    maxOfAveragedData = result[2];
  }

  /// Returns the Duration for averaging the given data
  Duration? getAverageDurationFromData() {
    try {
      Duration difference = chartData.last.x.difference(chartData.first.x);
      if (difference.inDays > 7) {
        return const Duration(days: 1);
      } else if (difference.inDays > 3) {
        return const Duration(hours: 1);
      } else if (difference.inHours > 36) {
        return const Duration(minutes: 30);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  /// Returns the average value of the given data for the given duration
  List<List<IoTDeviceHistoricalChartData>> averageMinMaxForGivenDuration(
      Duration duration) {
    List<IoTDeviceHistoricalChartData> minValues =
        <IoTDeviceHistoricalChartData>[];
    List<IoTDeviceHistoricalChartData> averageData =
        <IoTDeviceHistoricalChartData>[];
    List<IoTDeviceHistoricalChartData> maxValues =
        <IoTDeviceHistoricalChartData>[];

    for (DateTime i = _getStartingDateForDuration(chartData.first.x, duration);
        i.isBefore(chartData.last.x);
        i = i.add(duration)) {
      final List<IoTDeviceHistoricalChartData> filtered = chartData
          .where((element) =>
              element.x.compareTo(i) >= 0 &&
              element.x.isBefore(i.add(duration)))
          .toList();
      if (filtered.isEmpty) {
        continue;
      }

      final List<IoTDeviceHistoricalChartData> result = filtered
          .getAverageMaxMinForAllSensors(i, availableMetrics.keys.toList());
      averageData.add(result[1]);
      minValues.add(result[0]);
      maxValues.add(result[2]);
    }

    return [minValues, averageData, maxValues];
  }

  /// Returns the starting date to filter data for the given duration based on startDate
  DateTime _getStartingDateForDuration(
      DateTime startingDate, Duration duration) {
    if (duration.inDays == 1) {
      return DateTime(startingDate.year, startingDate.month, startingDate.day);
    } else if (duration.inHours == 1) {
      return DateTime(startingDate.year, startingDate.month, startingDate.day,
          startingDate.hour);
    } else if (duration.inMinutes == 30) {
      if (startingDate.minute < 30) {
        return DateTime(startingDate.year, startingDate.month, startingDate.day,
            startingDate.hour);
      } else {
        return DateTime(startingDate.year, startingDate.month, startingDate.day,
            startingDate.hour, 30);
      }
    } else {
      return DateTime(startingDate.year, startingDate.month, startingDate.day,
          startingDate.hour, startingDate.minute);
    }
  }
}

extension Average on List<IoTDeviceHistoricalChartData> {
  /// Returns the average value
  List<IoTDeviceHistoricalChartData> getAverageMaxMinForAllSensors(
      DateTime x, List<String> availableMetrics) {
    final IoTDeviceHistoricalChartData averageData =
        IoTDeviceHistoricalChartData(x: x);
    final IoTDeviceHistoricalChartData minData =
        IoTDeviceHistoricalChartData(x: x);
    final IoTDeviceHistoricalChartData maxData =
        IoTDeviceHistoricalChartData(x: x);

    for (String metric in availableMetrics) {
      averageData.y[metric] = 0;
      minData.y[metric] = double.infinity;
      maxData.y[metric] = double.negativeInfinity;
    }

    for (final IoTDeviceHistoricalChartData data in this) {
      for (String metric in availableMetrics) {
        if (data.y[metric] == null) {
          continue;
        }

        averageData.y[metric] = averageData.y[metric]! + data.y[metric]!;
        if (data.y[metric]! < minData.y[metric]!) {
          minData.y[metric] = data.y[metric];
        }
        if (data.y[metric]! > maxData.y[metric]!) {
          maxData.y[metric] = data.y[metric];
        }
      }
    }

    for (String metric in availableMetrics) {
      averageData.y[metric] =
          averageData.y[metric]! / (length == 0 ? 1 : length);
    }

    return [minData, averageData, maxData];
  }
}
