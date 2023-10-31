import 'package:management_dashboard/helper_functions.dart';

/// Class to store data for the datetime chart
class DateTimeChartData {
  /// x value
  final DateTime x;

  /// y value
  final double y;

  DateTimeChartData(this.x, this.y);

  /// Generate random data
  static List<DateTimeChartData> generateData() {
    return List.generate(
      20,
      (index) => DateTimeChartData(
        DateTime.now().add(Duration(hours: index * 8)),
        HelperFunctions.generateRandomDouble(20, 70).roundToDouble(),
      ),
    );
  }
}
