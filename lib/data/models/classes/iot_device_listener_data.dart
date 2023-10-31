import 'package:management_dashboard/data/models/enums/iot_listener_comparison.dart';

/// Class to hold Listener data for an IoT Device
class IoTDeviceListenerData {
  /// Document ID of the listener from Firebase
  String? listenerID;

  /// Name of the IoT Device for which the listener is being used
  String deviceName;

  /// Name of the Metric for which the listener is being used
  String variableName;

  /// Comparison with the threshold
  IoTListenerComparison comparison;

  /// Threshold after which the email should be sent
  double? threshold;

  /// Email at which the notification should go
  String? email;

  IoTDeviceListenerData({
    this.listenerID,
    required this.deviceName,
    required this.variableName,
    required this.comparison,
    this.threshold,
    this.email,
  });

  /// Converts IoTDeviceListenerData to Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'variableName': variableName,
      'comparison': comparison.sign,
      'threshold': threshold,
      'email': email,
      'deviceName': deviceName,
    };
  }

  /// Converts Map<String, dynamic> to IoTDeviceListenerData
  factory IoTDeviceListenerData.fromMap(Map<String, dynamic> map) {
    return IoTDeviceListenerData(
      variableName: map['variableName'],
      comparison: IoTListenerComparison.fromStringSign(map['comparison']),
      threshold: map['threshold'],
      email: map['email'],
      deviceName: map['deviceName'],
    );
  }

  /// Converts Map<String, dynamic> from Firebase to IoTDeviceListenerData
  factory IoTDeviceListenerData.fromFirebaseMap(
    Map<String, dynamic> map,
    String listenerID,
  ) {
    return IoTDeviceListenerData(
      listenerID: listenerID,
      variableName: map['variableName'],
      comparison: IoTListenerComparison.fromStringSign(map['comparison']),
      threshold: map['threshold'],
      email: map['email'],
      deviceName: map['deviceName'],
    );
  }
}
