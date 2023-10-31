class IoTDeviceHistoricalChartData {
  /// x is the date and time
  final DateTime x;

  /// y is a map that holds the values for each sensor
  Map<String, double?> y = {};

  IoTDeviceHistoricalChartData({
    required this.x,
    Map<String, double?>? y,
  }) {
    if (y != null) {
      this.y = y;
    }
  }

  /// Get max value of all the selected sensors
  double getMaxValueForGivenSensors({required List<String> selectedMetrics}) {
    double maxValue = double.negativeInfinity;
    for (final String metric in selectedMetrics) {
      if (y[metric] != null) {
        if (y[metric]! > maxValue) {
          maxValue = y[metric]!;
        }
      }
    }
    return maxValue == double.negativeInfinity ? 0 : maxValue;
  }
}
