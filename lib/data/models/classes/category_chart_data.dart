import 'package:flutter/material.dart';
import 'package:management_dashboard/helper_functions.dart';

/// Chart data class for Category type x axis
class CategoryChartData {
  /// x value
  final String x;

  /// y value
  final double y;

  /// Color of the data point
  final Color? color;

  CategoryChartData(this.x, this.y, {this.color});

  /// Generate random data
  static List<CategoryChartData> generateData() {
    return List.generate(
      7,
      (index) => CategoryChartData(
        HelperFunctions.getDayOfWeek(index + 1),
        HelperFunctions.generateRandomDouble(20, 70).roundToDouble(),
      ),
    );
  }
}
