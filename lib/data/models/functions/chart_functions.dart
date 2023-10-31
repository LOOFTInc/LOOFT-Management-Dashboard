import 'dart:html';

import 'package:flutter/material.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/iot_device.dart';
import 'package:management_dashboard/data/models/classes/iot_device_historical_chart_data.dart';
import 'package:management_dashboard/data/models/classes/iot_device_template.dart';
import 'package:management_dashboard/helper_functions.dart';

class ChartFunctions {
  /// Returns the data points for the day/night indicators
  static List<IoTDeviceHistoricalChartData> getDataPointsForDayNightIndicators(
      List<IoTDeviceHistoricalChartData> data) {
    final List<IoTDeviceHistoricalChartData> dataPoints =
        <IoTDeviceHistoricalChartData>[];
    for (DateTime i = data.first.x;
        i.isBefore(data.last.x);
        i = i.add(const Duration(hours: 1))) {
      if (i.hour == 5 || i.hour == 12 || i.hour == 19 || i.hour == 0) {
        dataPoints.add(IoTDeviceHistoricalChartData(x: i));
      }
    }
    return dataPoints;
  }

  /// Downloads the data for the selected device in the form of a csv, based on the selected categories
  static void downloadSelectedMetricsData({
    required IoTDevice device,
    IoTDeviceTemplate? template,
    List<String>? selectedMetrics,
  }) {
    if (device.historicalData == null ||
        device.historicalData!.rawData.isEmpty) {
      K.showToast(message: 'No Data to Download');
      return;
    }

    if (selectedMetrics?.isEmpty ?? false) {
      K.showToast(message: 'Select some categories to download data for');
      return;
    }

    String content = 'data:text/csv;charset=utf-8,';
    String deviceName = device.deviceName ?? '?';
    content += '$deviceName\n\n';

    content += 'Time,';
    for (String metric in selectedMetrics!) {
      String? metricName;
      try {
        metricName = template!.metrics
            .firstWhere((element) => element.variableName == metric)
            .getFullName();
      } catch (e) {}

      content += '${metricName ?? metric},';
    }

    content = content.substring(0, content.length - 1);
    content += '\n';

    for (Map<String, dynamic> data in device.historicalData!.rawData) {
      content += '${data['Time'].toDate()},';
      for (String metric in selectedMetrics) {
        content += '${data[metric]},';
      }

      content = content.substring(0, content.length - 1);
      content += '\n';
    }

    DateTime start = device.historicalData!.rawData.first['Time'].toDate();
    DateTime end = device.historicalData!.rawData.last['Time'].toDate();

    String fileName = '${deviceName}_'
        '${HelperFunctions.twoDigits(start.day)}${HelperFunctions.twoDigits(start.month)}${start.year}-'
        '${HelperFunctions.twoDigits(end.day)}${HelperFunctions.twoDigits(end.month)}${end.year}';

    AnchorElement(href: content)
      ..setAttribute("download", "$fileName.csv")
      ..click();
  }

  /// Downloads the data for the selected device in the form of a csv for all categories
  static void downloadAllData({
    required IoTDevice device,
    IoTDeviceTemplate? template,
  }) {
    if (device.historicalData == null ||
        device.historicalData!.rawData.isEmpty) {
      K.showToast(message: 'No Data to Download');
      return;
    }

    String content = 'data:text/csv;charset=utf-8,';
    String deviceName = device.deviceName ?? '?';
    content += '$deviceName\n\n';

    content += 'Time,';
    for (String metric in device.historicalData!.availableMetrics.keys) {
      String? metricName;
      try {
        metricName = template!.metrics
            .firstWhere((element) => element.variableName == metric)
            .getFullName();
      } catch (e) {}

      content += '${metricName ?? metric},';
    }

    content = content.substring(0, content.length - 1);
    content += '\n';

    for (Map<String, dynamic> data in device.historicalData!.rawData) {
      content += '${data['Time'].toDate()},';
      for (String metric in device.historicalData!.availableMetrics.keys) {
        content += '${data[metric]},';
      }

      content = content.substring(0, content.length - 1);
      content += '\n';
    }

    DateTime start = device.historicalData!.rawData.first['Time'].toDate();
    DateTime end = device.historicalData!.rawData.last['Time'].toDate();

    String fileName = '${deviceName}_'
        '${HelperFunctions.twoDigits(start.day)}${HelperFunctions.twoDigits(start.month)}${start.year}-'
        '${HelperFunctions.twoDigits(end.day)}${HelperFunctions.twoDigits(end.month)}${end.year}';

    AnchorElement(href: content)
      ..setAttribute("download", "$fileName.csv")
      ..click();
  }

  /// Returns text for the day/night indicators
  static String getDayNightTextFromDateTime(DateTime dateTime) {
    if (dateTime.hour == 5) {
      return 'Sunrise';
    } else if (dateTime.hour == 12) {
      return 'Noon';
    } else if (dateTime.hour == 19) {
      return 'Sunset';
    } else {
      return 'Night';
    }
  }

  /// Returns a list of data points for the day night indicators
  static LinearGradient getGradientFromData(
      List<IoTDeviceHistoricalChartData> data) {
    int totalHours = data.last.x.difference(data.first.x).inHours;
    List<Color> colors = <Color>[];
    List<double> stops = <double>[];

    colors.add(_getColorFromHour(data.first.x.hour));
    stops.add(0);

    for (DateTime i = data.first.x;
        i.isBefore(data.last.x);
        i = i.add(const Duration(hours: 1))) {
      if (i.hour == 5 || i.hour == 12 || i.hour == 19 || i.hour == 0) {
        colors.add(_getColorFromHour(i.hour));
        stops.add(i.difference(data.first.x).inHours / totalHours);
      }
    }

    colors.add(_getColorFromHour(data.last.x.hour));
    stops.add(1);

    return LinearGradient(colors: colors, stops: stops);
  }

  /// Returns a color for the given hour
  static Color _getColorFromHour(int hour) {
    if (hour == 5) {
      return const Color(0xFF866AA6);
    } else if (hour == 12) {
      return K.primaryPink;
    } else if (hour == 19) {
      return const Color(0xFF866AA6);
    } else if (hour == 0) {
      return K.primaryBlue;
    } else if (hour == 1) {
      return const Color(0xFF3C9ED6);
    } else if (hour == 2) {
      return const Color(0xFF4E91CA);
    } else if (hour == 3) {
      return const Color(0xFF6184BE);
    } else if (hour == 4) {
      return const Color(0xFF7377B2);
    } else if (hour == 6) {
      return const Color(0xFF93619D);
    } else if (hour == 7) {
      return const Color(0xFFA05795);
    } else if (hour == 8) {
      return const Color(0xFFAD4E8C);
    } else if (hour == 9) {
      return const Color(0xFFBB4584);
    } else if (hour == 10) {
      return const Color(0xFFC83C7B);
    } else if (hour == 11) {
      return const Color(0xFFD53273);
    } else if (hour == 13) {
      return const Color(0xFFD53273);
    } else if (hour == 14) {
      return const Color(0xFFC83C7B);
    } else if (hour == 15) {
      return const Color(0xFFBB4584);
    } else if (hour == 16) {
      return const Color(0xFFAD4E8C);
    } else if (hour == 17) {
      return const Color(0xFFA05795);
    } else if (hour == 18) {
      return const Color(0xFF93619D);
    } else if (hour == 20) {
      return const Color(0xFF7377B2);
    } else if (hour == 21) {
      return const Color(0xFF6184BE);
    } else if (hour == 22) {
      return const Color(0xFF4E91CA);
    } else if (hour == 23) {
      return const Color(0xFF3C9ED6);
    } else {
      return const Color(0xFF866AA6);
    }
  }
}
